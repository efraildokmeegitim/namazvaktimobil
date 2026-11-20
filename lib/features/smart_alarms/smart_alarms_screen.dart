import 'package:flutter/material.dart';
import '../../core/notifications/lock_screen_prayer_notification_service.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';

enum SmartAlarmKind {
  prayerRelative('Namaz Vaktine Göreli (Dinamik)'),
  specificDate('Belirli Bir Tarih ve Saat'),
  fixedTime('Sabit Saat / Günlük'),
  weekly('Haftalık Özel (Cuma / Sünnet Orucu)');

  final String label;
  const SmartAlarmKind(this.label);
}

class SmartAlarmModel {
  final String id;
  final String title;
  final SmartAlarmKind kind;
  final String timeDetail;
  final String soundTitle;
  bool isEnabled;

  SmartAlarmModel({
    required this.id,
    required this.title,
    required this.kind,
    required this.timeDetail,
    required this.soundTitle,
    this.isEnabled = true,
  });
}

class SmartAlarmsScreen extends StatefulWidget {
  const SmartAlarmsScreen({super.key});

  @override
  State<SmartAlarmsScreen> createState() => _SmartAlarmsScreenState();
}

class _SmartAlarmsScreenState extends State<SmartAlarmsScreen> {
  final List<SmartAlarmModel> _alarmList = [
    SmartAlarmModel(
      id: '1',
      title: 'Teheccüd & Sahur Uyarısı',
      kind: SmartAlarmKind.prayerRelative,
      timeDetail: 'İmsak vaktinden 45 dk önce',
      soundTitle: 'Saba Makamı Ezan Uyarısı',
      isEnabled: true,
    ),
    SmartAlarmModel(
      id: '2',
      title: 'İşrak Namazı Hatırlatması',
      kind: SmartAlarmKind.prayerRelative,
      timeDetail: 'Güneş doğumundan 50 dk sonra (Kerahat bitimi)',
      soundTitle: 'Hafif Çan / Su Sesi',
      isEnabled: true,
    ),
    SmartAlarmModel(
      id: '3',
      title: 'Evvâbîn ve Akşam Dua Dersi',
      kind: SmartAlarmKind.prayerRelative,
      timeDetail: 'Akşam namazından 20 dk sonra',
      soundTitle: 'Segah Ezan Kısa Tonu',
      isEnabled: false,
    ),
    SmartAlarmModel(
      id: '4',
      title: 'Pazartesi-Perşembe Sünnet Orucu',
      kind: SmartAlarmKind.weekly,
      timeDetail: 'Pazar ve Çarşamba 21:30\'da niyet hatırlatması',
      soundTitle: 'Kandil Hatırlatıcı Ton',
      isEnabled: true,
    ),
    SmartAlarmModel(
      id: '5',
      title: 'Cuma Kehf Sûresi ve Salavât',
      kind: SmartAlarmKind.weekly,
      timeDetail: 'Her Cuma 10:30',
      soundTitle: 'Salavat Melodisi',
      isEnabled: true,
    ),
  ];

  void _showAddAlarmModal() {
    final titleController = TextEditingController();
    SmartAlarmKind selectedKind = SmartAlarmKind.specificDate;
    DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
    String selectedPrayer = 'İmsak';
    int offsetMinutes = 30;
    String selectedSound = 'Makamlı Ezan Tonu';
    TimeOfDay selectedFixedTime = const TimeOfDay(hour: 7, minute: 0);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              decoration: const BoxDecoration(
                color: SukunColors.carbonCardSurface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                border: Border(top: BorderSide(color: SukunColors.goldAccent, width: 1.5)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 44,
                        height: 4,
                        decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Icon(Icons.add_alarm_rounded, color: SukunColors.goldAccent, size: 22),
                        SizedBox(width: 8),
                        Text(
                          'Yeni Akıllı Alarm Kur',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: titleController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Alarm Başlığı (Ör: Arefe Günü Teheccüd)',
                        labelStyle: const TextStyle(color: Colors.white60),
                        filled: true,
                        fillColor: Colors.black.withValues(alpha: 0.3),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: SukunColors.emeraldPrimary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Alarm Türü', style: TextStyle(color: SukunColors.goldAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: SmartAlarmKind.values.map((k) {
                        final isSel = k == selectedKind;
                        return ChoiceChip(
                          label: Text(k.label, style: const TextStyle(fontSize: 12)),
                          selected: isSel,
                          onSelected: (_) => setModalState(() => selectedKind = k),
                          selectedColor: SukunColors.emeraldPrimary.withValues(alpha: 0.35),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    if (selectedKind == SmartAlarmKind.specificDate) ...[
                      // Belirli Tarih ve Saat Seçimi
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              tileColor: Colors.black.withValues(alpha: 0.3),
                              leading: const Icon(Icons.calendar_month_rounded, color: SukunColors.goldAccent),
                              title: const Text('Tarih', style: TextStyle(color: Colors.white70, fontSize: 11)),
                              subtitle: Text(
                                '${selectedDate.day.toString().padLeft(2, '0')}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.year}',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 730)),
                                );
                                if (picked != null) {
                                  setModalState(() => selectedDate = picked);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ListTile(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              tileColor: Colors.black.withValues(alpha: 0.3),
                              leading: const Icon(Icons.access_time_rounded, color: SukunColors.emeraldPrimary),
                              title: const Text('Saat', style: TextStyle(color: Colors.white70, fontSize: 11)),
                              subtitle: Text(
                                selectedFixedTime.format(context),
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              onTap: () async {
                                final picked = await showTimePicker(context: context, initialTime: selectedFixedTime);
                                if (picked != null) {
                                  setModalState(() => selectedFixedTime = picked);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ] else if (selectedKind == SmartAlarmKind.prayerRelative) ...[
                      const Text('Bağlı Namaz Vakti', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: selectedPrayer,
                        dropdownColor: SukunColors.carbonCardSurface,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black.withValues(alpha: 0.3),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        items: ['İmsak', 'Güneş', 'Öğle', 'İkindi', 'Akşam', 'Yatsı']
                            .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                            .toList(),
                        onChanged: (v) => setModalState(() => selectedPrayer = v ?? 'İmsak'),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Vakitten Kaç Dk Önce/Sonra: $offsetMinutes dk', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                      Slider(
                        value: offsetMinutes.toDouble(),
                        min: 5,
                        max: 90,
                        divisions: 17,
                        activeColor: SukunColors.emeraldPrimary,
                        label: '$offsetMinutes dk',
                        onChanged: (val) => setModalState(() => offsetMinutes = val.round()),
                      ),
                    ] else ...[
                      ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        tileColor: Colors.black.withValues(alpha: 0.3),
                        leading: const Icon(Icons.access_time_rounded, color: SukunColors.goldAccent),
                        title: const Text('Saat Seçin', style: TextStyle(color: Colors.white)),
                        trailing: Text(
                          selectedFixedTime.format(context),
                          style: const TextStyle(color: SukunColors.goldAccent, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        onTap: () async {
                          final picked = await showTimePicker(context: context, initialTime: selectedFixedTime);
                          if (picked != null) {
                            setModalState(() => selectedFixedTime = picked);
                          }
                        },
                      ),
                    ],

                    const SizedBox(height: 16),
                    const Text('Uyarı Sesi', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: selectedSound,
                      dropdownColor: SukunColors.carbonCardSurface,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black.withValues(alpha: 0.3),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: [
                        'Makamlı Ezan Tonu',
                        'Saba Makamı Ezan Uyarısı',
                        'Segah Ezan Kısa Tonu',
                        'Ney Sesi & İntibah',
                        'Hafif Çan / Su Sesi',
                        'Sessiz / Yalnız Titreşim',
                      ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (v) => setModalState(() => selectedSound = v ?? 'Makamlı Ezan Tonu'),
                    ),

                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SukunColors.emeraldPrimary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      icon: const Icon(Icons.save_rounded),
                      label: const Text('Alarmı Kaydet ve Etkinleştir', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      onPressed: () {
                        final title = titleController.text.trim().isEmpty ? 'Özel Hatırlatıcı' : titleController.text.trim();
                        final String detail;
                        if (selectedKind == SmartAlarmKind.specificDate) {
                          final d = '${selectedDate.day.toString().padLeft(2, '0')}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.year}';
                          detail = '$d ${selectedFixedTime.format(context)} vaktinde';
                        } else if (selectedKind == SmartAlarmKind.prayerRelative) {
                          detail = '$selectedPrayer vaktinden $offsetMinutes dk önce';
                        } else {
                          detail = '${selectedFixedTime.format(context)} vaktinde';
                        }

                        setState(() {
                          _alarmList.insert(
                            0,
                            SmartAlarmModel(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                              title: title,
                              kind: selectedKind,
                              timeDetail: detail,
                              soundTitle: selectedSound,
                              isEnabled: true,
                            ),
                          );
                        });

                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$title başarıyla kuruldu.'),
                            backgroundColor: SukunColors.emeraldPrimary,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akıllı & Dinamik Alarmlar', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alarm_rounded, color: SukunColors.goldAccent),
            tooltip: 'Yeni Alarm Ekle',
            onPressed: _showAddAlarmModal,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          // Kilit Ekranı Canlı Bildirim Ayarı
          SukunSurfaceCard(
            enableGlass: true,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: SukunColors.goldAccent.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.screen_lock_portrait_rounded,
                    color: SukunColors.goldAccent,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kilit Ekranında Vakitler',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Kilit ekranında ve bildirim çubuğunda canlı geri sayım ve 5 vakit özeti',
                        style: TextStyle(fontSize: 12, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: LockScreenPrayerNotificationService.isLockScreenEnabled,
                  activeThumbColor: SukunColors.goldAccent,
                  onChanged: (val) {
                    setState(() {
                      LockScreenPrayerNotificationService.setLockScreenEnabled(val);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(val ? 'Kilit ekranında namaz vakitleri etkinleştirildi.' : 'Kilit ekranı bildirimi devre dışı bırakıldı.'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 14, 20, 6),
            child: Text(
              'AKILLI & DİNAMİK VAKİT ALARMLARI',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: SukunColors.goldAccent, letterSpacing: 1.1),
            ),
          ),
          ..._alarmList.map((alarm) {
            return SukunSurfaceCard(
              enableGlass: true,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (alarm.isEnabled ? SukunColors.emeraldPrimary : Colors.white12).withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      alarm.kind == SmartAlarmKind.prayerRelative
                          ? Icons.wb_twilight_rounded
                          : (alarm.kind == SmartAlarmKind.specificDate ? Icons.calendar_month_rounded : Icons.alarm_rounded),
                      color: alarm.isEnabled ? SukunColors.emeraldPrimary : Colors.white38,
                      size: 22,
                    ),
                  ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alarm.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        alarm.kind.label,
                        style: const TextStyle(fontSize: 11, color: SukunColors.goldAccent, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        alarm.timeDetail,
                        style: const TextStyle(fontSize: 12, color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.music_note_rounded, size: 12, color: Colors.white38),
                          const SizedBox(width: 4),
                          Text(alarm.soundTitle, style: const TextStyle(fontSize: 10, color: Colors.white38)),
                        ],
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: alarm.isEnabled,
                  activeThumbColor: SukunColors.emeraldPrimary,
                  onChanged: (val) {
                    setState(() {
                      alarm.isEnabled = val;
                    });
                  },
                ),
              ],
            ),
          );
        }),
      ],
    ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: SukunColors.emeraldPrimary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_alarm_rounded),
        label: const Text('Yeni Alarm Ekle', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: _showAddAlarmModal,
      ),
    );
  }
}
