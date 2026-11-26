package com.sukun.app.sukun_app

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Build
import androidx.core.app.NotificationCompat
import android.media.AudioManager
import android.media.MediaPlayer
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity(), SensorEventListener {
    private val CHANNEL_LOCKSCREEN = "com.sukun.app/lockscreen_notification"
    private val CHANNEL_WIDGET = "com.sukun.app/widget_bridge"
    private val CHANNEL_COMPASS = "com.sukun.app/compass_sensor"
    private val CHANNEL_AUDIO = "com.sukun.app/quran_audio"
    private val CHANNEL_RINGER = "com.sukun.app/ringer_mode"
    private val CHANNEL_VIBRATION = "com.sukun.app/vibration"
    private val NOTIFICATION_ID = 1001
    private val NOTIFICATION_CHANNEL_ID = "sukun_prayer_lockscreen_channel"

    private var mediaPlayer: MediaPlayer? = null

    private var sensorManager: SensorManager? = null
    private var rotationVectorSensor: Sensor? = null
    private var accelerometer: Sensor? = null
    private var magnetometer: Sensor? = null

    private var lastAccelerometer = FloatArray(3)
    private var lastMagnetometer = FloatArray(3)
    private var lastAccelerometerSet = false
    private var lastMagnetometerSet = false

    private val rotationMatrix = FloatArray(9)
    private val orientation = FloatArray(3)

    private var compassEventSink: EventChannel.EventSink? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Lock Screen Persistent Notification Channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_LOCKSCREEN).setMethodCallHandler { call, result ->
            when (call.method) {
                "showLockScreenNotification" -> {
                    val title = call.argument<String>("title") ?: "SÜKÛN • Vakit"
                    val subtitle = call.argument<String>("subtitle") ?: ""
                    val details = call.argument<String>("details") ?: ""
                    val nextPrayerName = call.argument<String>("nextPrayerName") ?: "Vakit"
                    val countdown = call.argument<String>("countdown") ?: ""
                    val location = call.argument<String>("location") ?: "İstanbul"
                    val hijriDate = call.argument<String>("hijriDate") ?: ""
                    val fajr = call.argument<String>("fajr") ?: "--:--"
                    val sunrise = call.argument<String>("sunrise") ?: "--:--"
                    val dhuhr = call.argument<String>("dhuhr") ?: "--:--"
                    val asr = call.argument<String>("asr") ?: "--:--"
                    val maghrib = call.argument<String>("maghrib") ?: "--:--"
                    val isha = call.argument<String>("isha") ?: "--:--"
                    val quote = call.argument<String>("quote") ?: "Kalpler ancak Allah'ı anmakla sükûnet bulur. (Ra'd, 28)"

                    showLockScreenNotification(
                        title = title,
                        subtitle = subtitle,
                        details = details,
                        nextPrayerName = nextPrayerName,
                        countdown = countdown,
                        location = location,
                        hijriDate = hijriDate,
                        fajr = fajr,
                        sunrise = sunrise,
                        dhuhr = dhuhr,
                        asr = asr,
                        maghrib = maghrib,
                        isha = isha,
                        quote = quote
                    )
                    result.success(true)
                }
                "requestNotificationPermission" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                        requestPermissions(arrayOf(android.Manifest.permission.POST_NOTIFICATIONS), 101)
                    }
                    result.success(true)
                }
                "clearLockScreenNotification" -> {
                    clearLockScreenNotification()
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }

        // Widget Bridge Channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_WIDGET).setMethodCallHandler { call, result ->
            when (call.method) {
                "reloadAllTimelines" -> {
                    SukunWidgetProvider.updateAllWidgets(this)
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }

        // Compass Sensor EventChannel
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_COMPASS).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    compassEventSink = events
                    startCompassSensors()
                }

                override fun onCancel(arguments: Any?) {
                    stopCompassSensors()
                    compassEventSink = null
                }
            }
        )

        // Quran Audio Native MediaPlayer Channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_AUDIO).setMethodCallHandler { call, result ->
            when (call.method) {
                "playAudioUrl" -> {
                    val url = call.argument<String>("url")
                    if (url.isNullOrEmpty()) {
                        result.error("INVALID_URL", "Audio URL cannot be null or empty", null)
                        return@setMethodCallHandler
                    }
                    try {
                        mediaPlayer?.release()
                        mediaPlayer = MediaPlayer().apply {
                            setDataSource(url)
                            setOnPreparedListener { start() }
                            setOnCompletionListener {
                                // Flutter tarafına bildirim göndermek gerekirse methodchannel invoke edilebilir
                            }
                            prepareAsync()
                        }
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("AUDIO_ERROR", e.localizedMessage, null)
                    }
                }
                "pauseAudio" -> {
                    try {
                        if (mediaPlayer?.isPlaying == true) {
                            mediaPlayer?.pause()
                        }
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("AUDIO_ERROR", e.localizedMessage, null)
                    }
                }
                "stopAudio" -> {
                    try {
                        mediaPlayer?.stop()
                        mediaPlayer?.release()
                        mediaPlayer = null
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("AUDIO_ERROR", e.localizedMessage, null)
                    }
                }
                "isPlaying" -> {
                    val playing = mediaPlayer?.isPlaying == true
                    result.success(playing)
                }
                else -> result.notImplemented()
            }
        }

        // Akıllı Cami / Sessiz Modu (Ringer Mode) Channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_RINGER).setMethodCallHandler { call, result ->
            val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
            when (call.method) {
                "setSilentMode" -> {
                    try {
                        audioManager.ringerMode = AudioManager.RINGER_MODE_VIBRATE
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("RINGER_ERROR", e.localizedMessage, null)
                    }
                }
                "setNormalMode" -> {
                    try {
                        audioManager.ringerMode = AudioManager.RINGER_MODE_NORMAL
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("RINGER_ERROR", e.localizedMessage, null)
                    }
                }
                "getRingerMode" -> {
                    val mode = when (audioManager.ringerMode) {
                        AudioManager.RINGER_MODE_SILENT -> "silent"
                        AudioManager.RINGER_MODE_VIBRATE -> "vibrate"
                        else -> "normal"
                    }
                    result.success(mode)
                }
                else -> result.notImplemented()
            }
        }

        // Tasbih Haptic & Target Vibration Channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_VIBRATION).setMethodCallHandler { call, result ->
            val vibrator = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                val vibratorManager = getSystemService(Context.VIBRATOR_MANAGER_SERVICE) as android.os.VibratorManager
                vibratorManager.defaultVibrator
            } else {
                @Suppress("DEPRECATION")
                getSystemService(Context.VIBRATOR_SERVICE) as android.os.Vibrator
            }

            when (call.method) {
                "vibrateTargetReached" -> {
                    try {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                            // Belirgin çift titreşim darbesi (hedef tamamlandı uyarısı)
                            val timings = longArrayOf(0, 180, 100, 260)
                            val amplitudes = intArrayOf(0, 255, 0, 255)
                            val effect = android.os.VibrationEffect.createWaveform(timings, amplitudes, -1)
                            vibrator.vibrate(effect)
                        } else {
                            @Suppress("DEPRECATION")
                            vibrator.vibrate(longArrayOf(0, 180, 100, 260), -1)
                        }
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("VIBRATION_ERROR", e.localizedMessage, null)
                    }
                }
                "vibrateTick" -> {
                    try {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                            val effect = android.os.VibrationEffect.createOneShot(35, android.os.VibrationEffect.DEFAULT_AMPLITUDE)
                            vibrator.vibrate(effect)
                        } else {
                            @Suppress("DEPRECATION")
                            vibrator.vibrate(35)
                        }
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("VIBRATION_ERROR", e.localizedMessage, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun startCompassSensors() {
        if (sensorManager == null) {
            sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        }
        sensorManager?.let { sm ->
            rotationVectorSensor = sm.getDefaultSensor(Sensor.TYPE_ROTATION_VECTOR)
            if (rotationVectorSensor != null) {
                sm.registerListener(this, rotationVectorSensor, SensorManager.SENSOR_DELAY_UI)
            } else {
                accelerometer = sm.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
                magnetometer = sm.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD)
                accelerometer?.let { sm.registerListener(this, it, SensorManager.SENSOR_DELAY_UI) }
                magnetometer?.let { sm.registerListener(this, it, SensorManager.SENSOR_DELAY_UI) }
            }
        }
    }

    private fun stopCompassSensors() {
        sensorManager?.unregisterListener(this)
        lastAccelerometerSet = false
        lastMagnetometerSet = false
    }

    override fun onSensorChanged(event: SensorEvent?) {
        if (event == null) return

        if (event.sensor.type == Sensor.TYPE_ROTATION_VECTOR) {
            SensorManager.getRotationMatrixFromVector(rotationMatrix, event.values)
            SensorManager.getOrientation(rotationMatrix, orientation)
            var azimuthInDegrees = Math.toDegrees(orientation[0].toDouble()).toFloat()
            if (azimuthInDegrees < 0) {
                azimuthInDegrees += 360f
            }
            compassEventSink?.success(azimuthInDegrees.toDouble())
        } else {
            if (event.sensor.type == Sensor.TYPE_ACCELEROMETER) {
                System.arraycopy(event.values, 0, lastAccelerometer, 0, event.values.size)
                lastAccelerometerSet = true
            } else if (event.sensor.type == Sensor.TYPE_MAGNETIC_FIELD) {
                System.arraycopy(event.values, 0, lastMagnetometer, 0, event.values.size)
                lastMagnetometerSet = true
            }

            if (lastAccelerometerSet && lastMagnetometerSet) {
                val success = SensorManager.getRotationMatrix(rotationMatrix, null, lastAccelerometer, lastMagnetometer)
                if (success) {
                    SensorManager.getOrientation(rotationMatrix, orientation)
                    var azimuthInDegrees = Math.toDegrees(orientation[0].toDouble()).toFloat()
                    if (azimuthInDegrees < 0) {
                        azimuthInDegrees += 360f
                    }
                    compassEventSink?.success(azimuthInDegrees.toDouble())
                }
            }
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}

    private fun showLockScreenNotification(
        title: String,
        subtitle: String,
        details: String,
        nextPrayerName: String,
        countdown: String,
        location: String,
        hijriDate: String,
        fajr: String,
        sunrise: String,
        dhuhr: String,
        asr: String,
        maghrib: String,
        isha: String,
        quote: String
    ) {
        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                NOTIFICATION_CHANNEL_ID,
                "SÜKÛN Kilit Ekranı ve Bildirim Çubuğu",
                NotificationManager.IMPORTANCE_DEFAULT
            ).apply {
                description = "Kilit ekranı ve bildirim panelinde canlı namaz vakti tablosu ve geri sayım"
                setShowBadge(false)
                enableLights(false)
                enableVibration(false)
                lockscreenVisibility = NotificationCompat.VISIBILITY_PUBLIC
            }
            notificationManager.createNotificationChannel(channel)
        }

        val launchIntent = packageManager.getLaunchIntentForPackage(packageName) ?: Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(
            this,
            0,
            launchIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or (if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) PendingIntent.FLAG_IMMUTABLE else 0)
        )

        val countdownDisplay = if (countdown.isNotEmpty()) "$nextPrayerName: $countdown" else title
        val locationDisplay = if (hijriDate.isNotEmpty()) "$location • $hijriDate" else location

        // 1. Collapsed RemoteViews
        val collapsedViews = android.widget.RemoteViews(packageName, R.layout.sukun_notification_collapsed).apply {
            setTextViewText(R.id.notif_collapsed_location, "SÜKÛN • $location")
            setTextViewText(R.id.notif_collapsed_countdown, countdownDisplay)
            setTextViewText(R.id.notif_collapsed_fajr, fajr)
            setTextViewText(R.id.notif_collapsed_sunrise, sunrise)
            setTextViewText(R.id.notif_collapsed_dhuhr, dhuhr)
            setTextViewText(R.id.notif_collapsed_asr, asr)
            setTextViewText(R.id.notif_collapsed_maghrib, maghrib)
            setTextViewText(R.id.notif_collapsed_isha, isha)
        }

        // 2. Expanded RemoteViews
        val expandedViews = android.widget.RemoteViews(packageName, R.layout.sukun_notification_expanded).apply {
            setTextViewText(R.id.notif_expanded_location, locationDisplay)
            setTextViewText(R.id.notif_expanded_countdown, countdownDisplay)
            setTextViewText(R.id.notif_expanded_fajr, fajr)
            setTextViewText(R.id.notif_expanded_sunrise, sunrise)
            setTextViewText(R.id.notif_expanded_dhuhr, dhuhr)
            setTextViewText(R.id.notif_expanded_asr, asr)
            setTextViewText(R.id.notif_expanded_maghrib, maghrib)
            setTextViewText(R.id.notif_expanded_isha, isha)
            setTextViewText(R.id.notif_expanded_quote, quote)
        }

        val notification = NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID)
            .setSmallIcon(R.drawable.ic_sukun_notification)
            .setColor(0xFF1FA87C.toInt()) // Zümrüt Yeşili Tema Vurgusu
            .setContentTitle(title)
            .setContentText(subtitle)
            .setSubText("SÜKÛN")
            .setCustomContentView(collapsedViews)
            .setCustomBigContentView(expandedViews)
            .setStyle(NotificationCompat.DecoratedCustomViewStyle())
            .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
            .setOngoing(true)
            .setOnlyAlertOnce(true)
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setForegroundServiceBehavior(NotificationCompat.FOREGROUND_SERVICE_IMMEDIATE)
            .setContentIntent(pendingIntent)
            .build()

        notificationManager.notify(NOTIFICATION_ID, notification)
    }

    private fun clearLockScreenNotification() {
        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.cancel(NOTIFICATION_ID)
    }
}
