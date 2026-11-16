import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sukun_app/core/theme/sukun_theme.dart';
import 'package:sukun_app/core/ui_kit/ui_kit.dart';
import 'package:sukun_app/features/prayer_times/prayer_calculator_service.dart';
import 'package:sukun_app/features/prayer_times/prayer_times_provider.dart';
import 'package:sukun_app/main.dart';

void main() {
  testWidgets('SukunSurfaceCard renders child correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: SukunTheme.darkTheme,
        home: const Scaffold(
          body: SukunSurfaceCard(
            child: Text('Test İçerik'),
          ),
        ),
      ),
    );

    expect(find.text('Test İçerik'), findsOneWidget);
  });

  testWidgets('ArabicScriptBlock renders arabic and translation', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: SukunTheme.darkTheme,
        home: const Scaffold(
          body: ArabicScriptBlock(
            arabicText: 'بِسْمِ اللَّهِ',
            translation: 'Allahın adıyla',
          ),
        ),
      ),
    );

    expect(find.byWidgetPredicate((widget) => widget is RichText && widget.text.toPlainText().contains('بِسْمِ اللَّهِ')), findsOneWidget);
    expect(find.text('Allahın adıyla'), findsOneWidget);
  });

  testWidgets('SukunHomeScreen loads correctly in ProviderScope', (tester) async {
    final service = PrayerCalculatorService();
    final times = service.calculateTimes(
      latitude: 41.0082,
      longitude: 28.9784,
      date: DateTime.now(),
      locationName: 'İstanbul, Fatih',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activePrayerTimesProvider.overrideWith((ref) => Stream.value(times)),
        ],
        child: const SukunApp(),
      ),
    );

    await tester.pump();

    expect(find.text('İstanbul, Fatih'), findsOneWidget);
    expect(find.text('GÜNÜN HADİS-İ ŞERİFİ & TEFEKKÜRÜ'), findsOneWidget);
  });
}
