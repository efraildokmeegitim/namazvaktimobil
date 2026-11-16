package com.sukun.app.sukun_app

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.core.app.NotificationCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL_LOCKSCREEN = "com.sukun.app/lockscreen_notification"
    private val CHANNEL_WIDGET = "com.sukun.app/widget_bridge"
    private val NOTIFICATION_ID = 1001
    private val NOTIFICATION_CHANNEL_ID = "sukun_prayer_lockscreen_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Lock Screen Persistent Notification Channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_LOCKSCREEN).setMethodCallHandler { call, result ->
            when (call.method) {
                "showLockScreenNotification" -> {
                    val title = call.argument<String>("title") ?: "SÜKÛN • Vakit"
                    val subtitle = call.argument<String>("subtitle") ?: ""
                    val details = call.argument<String>("details") ?: ""
                    showLockScreenNotification(title, subtitle, details)
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
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun showLockScreenNotification(title: String, subtitle: String, details: String) {
        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                NOTIFICATION_CHANNEL_ID,
                "SÜKÛN Kilit Ekranı Namaz Vakitleri",
                NotificationManager.IMPORTANCE_LOW
            ).apply {
                description = "Kilit ekranı ve bildirim panelinde anlık namaz vakti ve geri sayım"
                setShowBadge(false)
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

        val notification = NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID)
            .setSmallIcon(android.R.drawable.ic_lock_idle_alarm)
            .setContentTitle(title)
            .setContentText(subtitle)
            .setSubText("SÜKÛN")
            .setStyle(NotificationCompat.BigTextStyle().bigText("$subtitle\n\n$details"))
            .setVisibility(NotificationCompat.VISIBILITY_PUBLIC) // Kilit ekranında açık içerik
            .setOngoing(true) // Kalıcı durum çubuğu bildirimi
            .setOnlyAlertOnce(true)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .setContentIntent(pendingIntent)
            .build()

        notificationManager.notify(NOTIFICATION_ID, notification)
    }

    private fun clearLockScreenNotification() {
        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.cancel(NOTIFICATION_ID)
    }
}
