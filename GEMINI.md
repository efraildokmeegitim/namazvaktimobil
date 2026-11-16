# SÜKÛN Workspace Rules (Strict Token Economy & High Craft)

## 1. Context & Reading Discipline (Inbound Token Saver)
- Full specs live in @PROJECT_SPEC.md and current progress lives in @STATE.md.
- NEVER read the entire @PROJECT_SPEC.md at once; read ONLY the section/line-range matching the active phase.
- NEVER re-read files already in session context. Use targeted `search_directory` or line-bounded `view_file`.
- NEVER read generated files (`*.g.dart`, `*.freezed.dart`, `*.drift.dart`), lockfiles, `build/`, or raw JSON/SQLite seed files in `assets/seed_data/`.
- Edit existing files surgically via `edit_file`; NEVER rewrite unchanged functions or regenerate full files.

## 2. Output & Communication Discipline (Outbound Token Saver)
- ZERO PROSE: No greetings, no motivational filler, no code walkthroughs, no repeating file contents in chat.
- Summarize completed work in at most 5 compact bullet lines, then update @STATE.md (max 30 lines total).
- Write ZERO redundant inline comments; code must be self-documenting. Reuse shared UI widgets from `lib/core/ui_kit/` instead of writing duplicate styling code.

## 3. CLI & Build Discipline (Prevent Retry Loops)
- Batch all Drift/Riverpod schema definitions per phase and run `dart run build_runner build --delete-conflicting-outputs` ONCE per phase.
- Always use quiet/compact CLI flags to prevent log bloat:
  - `flutter pub get --no-precompile`
  - `flutter analyze --no-pub --no-fatal-infos`
  - `flutter test --reporter compact`

## 4. Non-Negotiable Quality Invariants
- 100% Offline-First for prayer times, Qibla, Tasbih, downloaded Quran surahs, Erkam "Dualar ve Zikirler" book, smart alarms, and notes.
- Strict adherence to "Nur & Karbon" design tokens, tabular numerals on timers, and `KFGQPC Uthmanic Script HAFS` for Quranic text.
