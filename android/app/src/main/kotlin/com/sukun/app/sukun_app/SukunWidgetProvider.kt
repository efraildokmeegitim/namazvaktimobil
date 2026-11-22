package com.sukun.app.sukun_app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import org.json.JSONObject

class SukunWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    companion object {
        fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
            val prefs = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val jsonString = prefs.getString("flutter.sukun_widget_data", null)

            var location = "İstanbul"
            var nextPrayer = "İKİNDİ"
            var remaining = "02:14:35"
            var nextTime = "15:42"
            var fajr = "06:05"
            var sunrise = "07:32"
            var dhuhr = "13:02"
            var asr = "15:42"
            var maghrib = "18:01"
            var isha = "19:24"

            var hijriDate = "13 Cemâziyelâhir 1448"

            if (jsonString != null) {
                try {
                    val obj = JSONObject(jsonString)
                    location = obj.optString("locationName", location)
                    hijriDate = obj.optString("hijriDate", hijriDate)
                    nextPrayer = obj.optString("nextPrayerName", nextPrayer)
                    fajr = obj.optString("fajr", fajr)
                    sunrise = obj.optString("sunrise", sunrise)
                    dhuhr = obj.optString("dhuhr", dhuhr)
                    asr = obj.optString("asr", asr)
                    maghrib = obj.optString("maghrib", maghrib)
                    isha = obj.optString("isha", isha)

                    val remSec = obj.optLong("remainingSeconds", 0)
                    val h = remSec / 3600
                    val m = (remSec % 3600) / 60
                    val s = remSec % 60
                    remaining = String.format("%02d:%02d:%02d", h, m, s)
                    nextTime = when (nextPrayer.uppercase()) {
                        "İMSAK", "SABAH" -> fajr
                        "GÜNEŞ" -> sunrise
                        "ÖĞLE" -> dhuhr
                        "İKİNDİ" -> asr
                        "AKŞAM" -> maghrib
                        "YATSI" -> isha
                        else -> asr
                    }
                } catch (_: Exception) {}
            }

            // Small 2x2 widget
            val smallViews = RemoteViews(context.packageName, R.layout.sukun_widget_small_layout).apply {
                setTextViewText(R.id.widget_small_location, location)
                setTextViewText(R.id.widget_small_prayer_name, "$nextPrayer VAKTİNE")
                setTextViewText(R.id.widget_small_timer, remaining)
                setTextViewText(R.id.widget_small_prayer_time, "Vakit: $nextTime")

                val intent = Intent(context, MainActivity::class.java).apply {
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                }
                val pendingIntent = PendingIntent.getActivity(
                    context, 0, intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
                setOnClickPendingIntent(R.id.widget_small_root, pendingIntent)
            }

            // Medium 4x2 widget - Anasayfa ModernDashboardHero stili
            val mediumViews = RemoteViews(context.packageName, R.layout.sukun_widget_medium_layout).apply {
                setTextViewText(R.id.widget_medium_location, location)
                setTextViewText(R.id.widget_medium_hijri_date, hijriDate)
                setTextViewText(R.id.widget_medium_hero_label, "${nextPrayer.uppercase()} VAKTİNE KALAN")
                setTextViewText(R.id.widget_medium_hero_timer, remaining)
                setTextViewText(R.id.widget_medium_next_prayer_time, nextTime)

                setTextViewText(R.id.widget_time_fajr, fajr)
                setTextViewText(R.id.widget_time_sunrise, sunrise)
                setTextViewText(R.id.widget_time_dhuhr, dhuhr)
                setTextViewText(R.id.widget_time_asr, asr)
                setTextViewText(R.id.widget_time_maghrib, maghrib)
                setTextViewText(R.id.widget_time_isha, isha)

                // Dinamik Aktif Vakit Vurgulaması
                val prayerBoxes = mapOf(
                    "İMSAK" to Triple(R.id.widget_box_fajr, R.id.widget_label_fajr, R.id.widget_time_fajr),
                    "SABAH" to Triple(R.id.widget_box_fajr, R.id.widget_label_fajr, R.id.widget_time_fajr),
                    "GÜNEŞ" to Triple(R.id.widget_box_sunrise, R.id.widget_label_sunrise, R.id.widget_time_sunrise),
                    "ÖĞLE" to Triple(R.id.widget_box_dhuhr, R.id.widget_label_dhuhr, R.id.widget_time_dhuhr),
                    "İKİNDİ" to Triple(R.id.widget_box_asr, R.id.widget_label_asr, R.id.widget_time_asr),
                    "AKŞAM" to Triple(R.id.widget_box_maghrib, R.id.widget_label_maghrib, R.id.widget_time_maghrib),
                    "YATSI" to Triple(R.id.widget_box_isha, R.id.widget_label_isha, R.id.widget_time_isha)
                )

                val normalizedPrayer = nextPrayer.uppercase()
                for ((key, ids) in prayerBoxes) {
                    val (boxId, labelId, timeId) = ids
                    if (key == normalizedPrayer) {
                        setInt(boxId, "setBackgroundResource", R.drawable.sukun_widget_active_box)
                        setTextColor(labelId, 0xFF35B888.toInt())
                        setTextColor(timeId, 0xFFE5C170.toInt())
                    } else {
                        setInt(boxId, "setBackgroundResource", R.drawable.sukun_widget_transparent_box)
                        setTextColor(labelId, 0xFF9EAEAA.toInt())
                        setTextColor(timeId, 0xFFFFFFFF.toInt())
                    }
                }

                val intent = Intent(context, MainActivity::class.java).apply {
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                }
                val pendingIntent = PendingIntent.getActivity(
                    context, 1, intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
                setOnClickPendingIntent(R.id.widget_medium_root, pendingIntent)
            }

            val appWidgetInfo = appWidgetManager.getAppWidgetInfo(appWidgetId)
            if (appWidgetInfo != null && appWidgetInfo.initialLayout == R.layout.sukun_widget_medium_layout) {
                appWidgetManager.updateAppWidget(appWidgetId, mediumViews)
            } else {
                appWidgetManager.updateAppWidget(appWidgetId, smallViews)
            }
        }

        fun updateSmallWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }

        fun updateMediumWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }

        fun updateAllWidgets(context: Context) {
            val appWidgetManager = AppWidgetManager.getInstance(context)
            val smallIds = appWidgetManager.getAppWidgetIds(ComponentName(context, SukunWidgetSmallProvider::class.java))
            for (id in smallIds) {
                updateAppWidget(context, appWidgetManager, id)
            }
            val mediumIds = appWidgetManager.getAppWidgetIds(ComponentName(context, SukunWidgetMediumProvider::class.java))
            for (id in mediumIds) {
                updateAppWidget(context, appWidgetManager, id)
            }
            SukunWidgetTasbihProvider.updateAllTasbihWidgets(context)
        }
    }
}

class SukunWidgetSmallProvider : AppWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        for (id in appWidgetIds) {
            SukunWidgetProvider.updateAppWidget(context, appWidgetManager, id)
        }
    }
}

class SukunWidgetMediumProvider : AppWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        for (id in appWidgetIds) {
            SukunWidgetProvider.updateAppWidget(context, appWidgetManager, id)
        }
    }
}

class SukunWidgetTasbihProvider : AppWidgetProvider() {

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        for (id in appWidgetIds) {
            updateTasbihWidget(context, appWidgetManager, id)
        }
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        val prefs = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)

        when (intent.action) {
            ACTION_INCREMENT -> {
                val current = prefs.getInt(PREF_KEY_COUNT, 0)
                val newCount = current + 1
                prefs.edit().putInt(PREF_KEY_COUNT, newCount).apply()
                updateAllTasbihWidgets(context)
            }
            ACTION_RESET -> {
                prefs.edit().putInt(PREF_KEY_COUNT, 0).apply()
                updateAllTasbihWidgets(context)
            }
        }
    }

    companion object {
        const val ACTION_INCREMENT = "com.sukun.app.ACTION_TASBIH_INCREMENT"
        const val ACTION_RESET = "com.sukun.app.ACTION_TASBIH_RESET"
        private const val PREF_KEY_COUNT = "flutter.tasbih_widget_count"
        private const val PREF_KEY_NAME = "flutter.tasbih_widget_dhikr_name"

        fun updateTasbihWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
            val prefs = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val count = prefs.getInt(PREF_KEY_COUNT, 0)
            val dhikrName = prefs.getString(PREF_KEY_NAME, "Sübhânallâhi ve bi-hamdihî") ?: "Sübhânallâhi ve bi-hamdihî"

            val views = RemoteViews(context.packageName, R.layout.sukun_widget_tasbih_layout).apply {
                setTextViewText(R.id.widget_tasbih_counter, count.toString())
                setTextViewText(R.id.widget_tasbih_dhikr_name, dhikrName)

                // Tap on Center Area -> Increment
                val incIntent = Intent(context, SukunWidgetTasbihProvider::class.java).apply {
                    action = ACTION_INCREMENT
                }
                val incPending = PendingIntent.getBroadcast(
                    context, 201, incIntent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
                )
                setOnClickPendingIntent(R.id.widget_tasbih_btn_tap, incPending)

                // Tap on Corner Reset Button -> Reset
                val resetIntent = Intent(context, SukunWidgetTasbihProvider::class.java).apply {
                    action = ACTION_RESET
                }
                val resetPending = PendingIntent.getBroadcast(
                    context, 202, resetIntent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
                )
                setOnClickPendingIntent(R.id.widget_tasbih_btn_reset, resetPending)
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }

        fun updateAllTasbihWidgets(context: Context) {
            val appWidgetManager = AppWidgetManager.getInstance(context)
            val ids = appWidgetManager.getAppWidgetIds(ComponentName(context, SukunWidgetTasbihProvider::class.java))
            for (id in ids) {
                updateTasbihWidget(context, appWidgetManager, id)
            }
        }
    }
}

