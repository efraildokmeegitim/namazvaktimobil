# SÜKÛN: Gelişmiş Namaz Vakti, İlmi Akış ve İslami Yaşam Platformu
**Kota Dostu (Zero-Waste Token) Google Antigravity Mimari ve Ürün Spesifikasyonu**

> **Kritik Kota Koruma Mimarisi (Nasıl Kullanılmalı?):**
> Google Antigravity, kök dizindeki `GEMINI.md` dosyasını **her mesajda (`always_on`)** modele yeniden gönderir. Binlerce satırlık bir ürün dokümanını doğrudan `GEMINI.md` içine koymak her adımda gereksiz kota tüketir.
> **Çözüm:**
> 1. Bu kapsamlı dosyayı proje kök dizinine **`PROJECT_SPEC.md`** adıyla kaydedin.
> 2. Aşağıdaki **Bölüm 0.1**'deki ultra-hafif kural bloğunu **`GEMINI.md`** olarak, **Bölüm 0.2**'deki filtre listesini ise **`.geminiignore`** (ve `.antigravityignore`) olarak kök dizine ekleyin.
> Böylece Antigravity her turda yalnızca ~350 token'lık sistem kuralını okur; büyük spesifikasyondan ise sadece o an kodladığı fazın satırlarını çağırır.

---

## 0. Antigravity Minimum Kota ve Token Ekonomisi Protokolü

### 0.1. Kök Dizine Konulacak Ultra-Hafif `GEMINI.md` Şablonu
Aşağıdaki bloğu kopyalayıp proje kök dizinine `GEMINI.md` olarak kaydedin (sistem önbelleğinden minimum maliyetle okunur):

~~~markdown
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
~~~

### 0.2. Kök Dizine Konulacak `.geminiignore` ve `.antigravityignore` Şablonu
Antigravity'nin arka planda tüm klasörü tarayıp kotanızı eritmesini engellemek için kök dizinde hem `.geminiignore` hem `.antigravityignore` oluşturup içine şu kuralları yapıştırın:

~~~gitignore
# Derleme ve IDE Çıktıları
build/
.dart_tool/
.idea/
.vscode/
ios/Pods/
ios/.symlinks/
ios/Flutter/ephemeral/
android/.gradle/
android/app/build/

# Otomatik Üretilen Kodlar (Ajanın okuması tamamen kota israfıdır)
**/*.g.dart
**/*.freezed.dart
**/*.drift.dart
**/*.gr.dart
pubspec.lock
ios/Podfile.lock

# Büyük Medya, Font ve Ham Veri Paketleri (Ajan sadece şemayı bilmelidir)
assets/audio/**
assets/fonts/**
assets/seed_data/*.json
assets/seed_data/*.db
assets/seed_data/*.sqlite
~~~

### 0.3. Geliştirme Sürecinde Kota Tasarrufu Sağlayan 6 Altın Kural (Kullanıcı Rehberi)
1. **Model Yönlendirmesi (`%80` Fast Mode / Flash - `%20` Planning Mode / Pro):**
   - **Planning Mode (Gemini Pro):** Yalnızca Faz 1 mimari kurulumunda, Faz 2/5 astronomi-trigonometri hesaplarında ve Faz 7 iOS/Android native widget köprülerinde açın.
   - **Fast Mode (Gemini 3 Flash + `Iterative` odak):** Ekran tasarımları, CRUD servisleri, Riverpod sağlayıcıları, liste ekranları ve ince ayarların tamamında **Fast Mode** kullanın; çok daha düşük kota harcar ve daha hızlıdır. Küçük satır düzeltmelerinde sınırsız olan **Tab Completion** özelliğini kullanın.
2. **Her Faz Sonunda "Yeni Sohbet" (Reset Context Rot):**
   - Aynı sohbet penceresinde 30 mesaj boyunca devam etmek, her yeni mesajda önceki 29 mesajın tamamını tekrar modele gönderir. Her faz bittiğinde ajan `STATE.md` dosyasını günceller; bir sonraki faza **yeni bir sohbet (New Session)** açarak başlayın. Bu yöntem tek başına toplam kotanın **`%60`'ını kurtarır**.
3. **Tohum Verileri (Seed Data) Yapay Zekaya Yazdırmayın:**
   - 6.236 Kur'an ayetini veya 296 sayfalık *Dualar ve Zikirler* metnini sohbet ekranında yapay zekaya ürettirmek yüz binlerce token yakar. Ajan yalnızca **JSON/SQLite içe aktarma motorunu (`SeedLoader`)** ve **3'er kayıtlık örnek test verisini** yazar; gerçek veri dosyalarını doğrudan `assets/seed_data/` klasörüne siz kopyalarsınız.
4. **Hata Düzeltmede Sohbet Yerine "Artifact / Satır Yorumu" Kullanın:**
   - Bir ekranda görsel veya mantıksal revizyon istediğinizde sohbete uzun açıklama yazmak yerine doğrudan ilgili kod satırını seçip yorum bırakın; ajan tüm projeyi taramak yerine yalnız o bloğu işler.
5. **Kullanılmayan MCP Sunucularını Kapatın:**
   - Aktif kullanmadığınız MCP eklentilerini Antigravity ayarlarından devre dışı bırakın (açık kalan her MCP sunucusu her mesajda araç tanımlarını bağlama yükler).
6. **Çoklu Ajan (`/teamwork`) Yerine Odaklı Tek-Geçiş (Single-Pass):**
   - Standart modüllerde `/teamwork` sürüsü başlatmayın; faz komutlarının sonuna *"Tek geçişte (single-pass) tamamla, ara onay sorma"* direktifi ekleyerek soru-cevap turlarını sıfırlayın.

---

## 1. Teknoloji Yığını ve Değişmez Mimari Kurallar

| Katman | Teknoloji / Paket | Kota ve Kalite Gerekçesi |
| :--- | :--- | :--- |
| **Çatı & Dil** | Flutter (Dart 3.x, Impeller) | Tek kod tabanından iOS ve Android'de $120\text{ Hz}$ akıcı arayüz; ayrı native UI yazma maliyetini ortadan kaldırır. |
| **Mimari** | Feature-First Modüler Yapı | Her özellik kendi klasöründe izoledir; ajan bir modülü kodlarken diğer modülleri okumak zorunda kalmaz. |
| **Durum Yönetimi** | Riverpod 2.x (`flutter_riverpod`) | Yalın, test edilebilir reaktif durum yönetimi. |
| **Yönlendirme** | `go_router` | Widget'lardan ve bildirimlerden doğrudan hedef sayfaya derin bağlantı (Deep Link). |
| **Yerel Veritabanı** | `drift` (SQLite + FTS5) | `%100` çevrimdışı çalışma ve Arapça/Türkçe metinlerde milisaniyelik tam metin araması. |
| **Namaz & Astronomi** | Diyanet API + `adhan_dart` | Resmi Diyanet vakitleriyle birebir uyum; internet kesildiğinde çevrimdışı astronomik hesaplama yedeği. |
| **Native Widget'lar** | iOS `WidgetKit`/`ActivityKit` (Swift), Android `Jetpack Glance`/`AlarmManager` (Kotlin) | Pil dostu, işletim sistemiyle tam bütünleşik modern widget'lar ve şaşmayan ezan alarmları. |
| **Harita & Cami** | Google Maps SDK, Places & Routes API | En yakın cami/mescit tespiti, yürüme mesafesi ve tek dokunuşla rota. |
| **Arka Plan & Ses** | `just_audio`, `audio_service`, `background_downloader` | Kilit ekranı kontrollü Kur'an tilaveti, makamlı ezan ve arka planda sure indirme. |

**Kesin Kalite ve Mahremiyet Sınırları:**
- **Çevrimdışı Garanti:** İnternet tamamen kapalıyken namaz vakitleri, kıble pusulası, tesbihmatik, indirilen Kur'an sureleri, *Dualar ve Zikirler* kitabı, akıllı alarmlar ve notlar kusursuz çalışır.
- **Huzur Prensibi:** İbadet, Kur'an ve dua ekranlarında dikkat dağıtıcı tam ekran reklam yer almaz; konum verisi üçüncü taraflarla paylaşılmaz.
- **Anahtar Güvenliği:** API anahtarları kaynak koda gömülmez, `--dart-define-from-file=.env` ile okunur.

---

## 2. "Nur & Karbon" Tasarım Sistemi ve Ortak Bileşen Kütüphanesi

### 2.1. Renk Token'ları ve Atmosferik Temalar
1. **Karbon & Zümrüt (Varsayılan Koyu Tema - Gerçek OLED Dostu):**
   - Zemin: `#080C0B` | Kart Yüzeyi: `#111816` | Cam Yüzey (Glass): `#16211E` (`%75` opaklık, $16\text{ px}$ blur) | Kenarlık: `#1F2E2A`
   - Birincil Vurgu (Huzur Zümrüdü): `#1FA87C` | İkincil Vurgu (Tezhip Altını): `#D4AF6A`
   - Birincil Metin: `#F0EFEA` | İkincil Metin: `#96A5A0`
2. **Nur & Fildişi (Aydınlık Tema):**
   - Zemin: `#FAF7F2` | Kart Yüzeyi: `#FFFFFF` | Kenarlık: `#E8E2D7`
   - Birincil Vurgu (Çini Yeşili): `#0D5C46` | İkincil Vurgu (Varak Kehribar): `#B8893D`
   - Birincil Metin: `#16201D` | İkincil Metin: `#5C6B66`
3. **Sepya / Kitap Kağıdı Modu (Okuma Ekranları):**
   - Kur'an-ı Kerim, *Dualar ve Zikirler* ve uzun ilmi okumalar için `#F3EACB` zemin, `#2B241B` mürekkep rengi.
4. **Vakte Duyarlı Dinamik Başlık Gradyanları:**
   - İmsak: `#141E30` -> `#6B495B` | Güneş/Öğle: `#0F4C5C` -> `#1B6B5A` | İkindi: `#3D4E42` -> `#8C6A43` | Akşam: `#2B1B3D` -> `#7A3E3E` | Yatsı: `#070B0E` -> `#102027`.

### 2.2. Tipografi Kuralları
- **Mushaf & Ayet:** `KFGQPC Uthmanic Script HAFS` (hareke çakışmasını önleyen `2.0` satır yüksekliği).
- **Dua & Hadis Arapça Metinleri:** `Amiri` veya `Scheherazade New`.
- **Arayüz & Widget'lar:** `Plus Jakarta Sans` (tüm geri sayım sayaçlarında `FontFeature.tabularFigures()` zorunludur; saniye değişirken rakamlar titremez).
- **Uzun Okuma & Kitap Alıntıları:** `Literata` (yüksek okunabilirlikli editoryal serif).

### 2.3. Kota Tasarruflu Ortak UI Primitifleri (`lib/core/ui_kit/`)
Faz 1'de aşağıdaki 6 çekirdek bileşen bir kez kusursuz biçimde yazılır ve tüm modüllerde tekrar kullanılır (kod tekrarını ve çıktı token tüketimini yarıdan fazla düşürür):
1. `SukunSurfaceCard`: İnce kenarlıklı, opsiyonel buzlu cam ve `%4` opaklıkta vektörel Selçuklu yıldız dokulu (`CustomPainter`) ana kart bileşeni.
2. `SkyCountdownHeader`: Vakte göre renk değiştiren, güneş yayını ve kalan süreyi gösteren animasyonlu üst başlık.
3. `ArabicScriptBlock`: Sağdan sola (RTL), ölçeklenebilir font boyutlu, okunuş (transliterasyon) ve meal aç/kapat destekli metin bloğu.
4. `CategoryFilterChips`: Yatay kaydırılabilir, seçili durumda zümrüt/altın vurgulu kategori çipleri.
5. `ShareStudioSheet`: Herhangi bir ayet, dua veya ilmi kartı $9:16$ (Hikaye), $1:1$ (Kare) ve $4:5$ (Portre) oranlarında yüksek çözünürlüklü PNG görsele dönüştüren ortak paylaşım motoru.
6. `ContextualActionRow`: Beğen, Koleksiyona Kaydet, Bağlamsal Not Ekle, Tesbihmatik'e Aktar ve Alarm Kur aksiyon çubuğu.

---

## 3. Modül Bazlı Fonksiyonel Spesifikasyonlar

### 3.1. Gelişmiş Namaz Vakti Motoru
- **Konum & Hesaplama:** GPS ile otomatik il/ilçe tespiti + çoklu şehir ekleme. Diyanet İşleri Başkanlığı resmi vakitlerinin 30/365 günlük yerel önbelleğe alınması; çevrimdışı veya yurt dışı durumda `adhan_dart` astronomik hesaplama yedeği (Diyanet, MWL, ISNA, Umm al-Qura metotları).
- **Güneş Yayı & Kerahat Rozeti:** Doğuş-batış eğrisi üzerinde anlık güneş konumu. Güneş doğduktan sonraki ilk $45\text{ dk}$, öğle öncesi istiva vakti ve akşamdan önceki son $45\text{ dk}$ içinde kehribar renkli *"Kerahat Vakti"* bilgilendirme rozeti.
- **Özelleştirilebilir Ezan & Uyarılar:** Her vakit için ayrı ses seçimi (*Sessiz*, *Uyarı Tonu*, *Kısa Ezan*, *Makamlı Tam Ezan*: Sabah-Saba, Öğle-Rast, İkindi-Hicaz, Akşam-Segah, Yatsı-Uşşak). Vakitten $15$/$30$/$45\text{ dk}$ önce *"Vaktin çıkmasına az kaldı"* uyarısı ve Cuma/vakit saatlerinde sessize alma yardımcısı.
- **Akıllı Seferilik Asistanı:** Kayıtlı "Ev Konumu"ndan $\ge 90\text{ km}$ uzaklaşıldığında otomatik *"Seferi Modu"* bilgilendirmesi ve yolcu namazı rehberi.

### 3.2. Çok Boyutlu Widget Ekosistemi ve Tasarım Stüdyosu
Uygulama içindeki **Widget Tasarım Stüdyosu** ile kullanıcı arka plan temasını (Karbon, Nur, Yarı Şeffaf Cam), yazı rengini ve vurgu tonunu seçebilir:
- **Small ($2 \times 2$):** Dairesel ilerleme halkası içinde sıradaki vakte geri sayım, vakit adı, ilçe ve Hicri tarih.
- **Medium ($4 \times 2$):** Altı vaktin yatay dizilimi, aktif vaktin parlak zümrüt/altın vurgu kutusuyla ayrışması, geri sayım ve Miladi/Hicri gün.
- **Large ($4 \times 4$):** Üstte 6 vakit ve sayaç + ortada her vakit yenilenen *Günün Ayeti / Hadisi / Özlü Sözü* + altta *Kıble, Tesbih, Dualar Kitabı, Kur'an* tek tık kısayolları.
- **İlmi Söz Widget'ı ($4 \times 2$):** Saatlik veya günlük değişen ayet, hadis ve tasavvufi hikmet kartı.
- **Kilit Ekranı & Canlı Etkinlik (iOS Dynamic Island / Android Ongoing Notification):** Kilit ekranı sayaç widget'ları ve özellikle Ramazan'da iftar/sahur son $60\text{ dakikasında}$ saniye bazlı canlı geri sayım.

### 3.3. "İlmi Akış" — Sosyal Medya Ergonomisinde İlim ve Hikmet Ortamı
Sıkılmadan, akıcı ve estetik kartlarla ilim öğrenmeyi sağlayan çift görünümlü sosyal akış modülü:
- **Görünüm Modları:** **Tam Ekran Dikey Kaydırma (Reels/Shorts Ergonomisi)** ve **Klasik Akış Listesi (Threads/X Ergonomisi)** arasında tek dokunuşla geçiş.
- **8 Temel İlim Kategorisi:**
  1. **Fıkıh:** Günlük ibadet ve muamelat meseleleri, "Doğru Bilinen Yanlışlar", mezhep görüşleriyle pratik soru-cevaplar.
  2. **Siyer:** Hz. Peygamber'in (s.a.v.) hayatından kronolojik kesitler, sahabe tabloları ve nebevi ahlak örnekleri.
  3. **Kelam:** İman hakikatleri, Esma ve Sıfat tefekkürü, çağdaş inanç sorularına özlü aklî/naklî cevaplar.
  4. **Hadis:** Sahih kaynaklardan (Kütüb-i Sitte, Riyâzü's-Sâlihîn) ravi/kaynak künyeli hadisler ve hayata bakan mesajı.
  5. **Ayet:** Harekeli Arapça hat, meal, nüzul sebebi ve tefsir nüktesi.
  6. **Özlü Söz:** İslam alimleri, arifler ve mütefekkirlerden vecizeler.
  7. **Kitap Alıntıları:** Seçkin eserlerden kitap adı, müellif ve sayfa numarası referanslı pasajlar.
  8. **Tasavvuf İlmi:** İhlas, edep, nefis terbiyesi, kalp tasfiyesi ve ariflerin hikmetli menkıbeleri.
- **Çeşitlilik Algoritması & "Derinleş" Çekmecesi:** Genel akışta aynı kategoriden üst üste 2'den fazla kart gelmez. Kart üzerindeki öz bilginin altındaki *"Şerhi Oku / Derinleş"* butonu alt çekmecede detaylı açıklamayı ve kaynakçayı açar.
- **Paylaşım ve Saklama:** `ShareStudioSheet` ile WhatsApp, Instagram, Telegram ve X'te şık görsel kart veya metin olarak paylaşım; **Daha Sonra Oku** ile kullanıcı tanımlı klasörlere kaydetme ve çevrimdışı okuma.

### 3.4. Erkam Yayınları: "Dualar ve Zikirler" (Mahmud Sami Ramazanoğlu) Modülü
- **Orijinal Eser Yapısı:** Kitabın ~296 sayfalık orijinal sayfa numaralandırması ve konu fihristi (Uyanınca, Evden Çıkarken, Mescid Duaları, Sabah-Akşam Evradı, Kur'an ve Sünnet Duaları, İstiğfarlar, Salavatlar, Hacet/İstihare/Şifa Duaları) birebir korunur.
- **Okuma Deneyimi:** **Orijinal Sayfa Görünümü** ve **Blok Görünümü** (Arapça metin + aç/kapat Türkçe okunuş + Türkçe meal/fazilet açıklaması); yazı boyutu ayarı ve Sepya/Karbon modu.
- **Sayfa Favorileme ve Ayraçlar:** Kitabın herhangi bir sayfası tek dokunuşla **"Favori Sayfalarım"** listesine eklenebilir, sayfaya özel başlık/etiket verilebilir, otomatik *"Kaldığım Sayfa"* şeridi ve çoklu ayraç tutulur.
- **Tesbihmatik & Vird Köprüsü:** Adetli zikir içeren sayfalarda *"Tesbihmatik ile Çek"* butonu hedef sayıyı otomatik kurarak zikir ekranını açar; *"Vird Hatırlatıcısı"* butonu ilgili sayfayı günlük alarma bağlar.

### 3.5. Kur'an-ı Kerim ve Çevrimdışı Sure İndirme Modülü
- **Mushaf & Meal Görünümü:** 604 sayfa standart Mushaf görünümü (cüz, hizb, secde işaretleri) ve ayet bazlı Meal/Muhtasar Tefsir inceleme görünümü.
- **Seçmeli Çevrimdışı İndirme Yöneticisi:** Kullanıcı dilediği sureleri, cüzleri ve hafız (kari) ses paketlerini seçerek indirir. Tek tıkla *"Sık Okunan Sureler Paketi"* (Yâsîn, Mülk, Nebe, Fetih, Kehf, Vâkıa, Rahmân, Cuma ve namaz sureleri) indirme seçeneği ve depolama temizleme ekranı bulunur.
- **Sesli Takip & Hatim:** Okunan ayetin anlık vurgulanması, ezber için ayet tekrarlama, hız ayarı ($0.75\times$ - $1.5\times$), kilit ekranı oynatıcısı ve hedef tarihli kişisel hatim planlayıcı.

### 3.6. Hassas Kıble Pusulası ve AR Modu
- **Matematiksel Doğruluk:** Kullanıcı koordinatı $(\phi_U, \lambda_U)$ ile Kabe koordinatı ($\phi_K = 21.422487^\circ$, $\lambda_K = 39.826206^\circ$) arasındaki büyük daire azimut açısı $Q$:
  $$Q = \operatorname{atan2}\left(\sin(\lambda_K - \lambda_U), \cos(\phi_U)\tan(\phi_K) - \sin(\phi_U)\cos(\lambda_K - \lambda_U)\right)$$
  WMM manyetik sapma (declination) düzeltmesi ve jiroskop/ivmeölçer eğim telafisi uygulanır.
- **3 Görünüm:** $\pm 2^\circ$ hizalamada haptik onay veren **Zarif Pusula**, manyetik parazitli iç mekanlar için **Uydu Haritası Kabe Hattı** ve **Kamera AR Kıble Görünümü**.

### 3.7. En Yakın Cami ve Mescit Bulucu
- Google Maps SDK ve Places API üzerinden çevredeki cami ve mescitlerin haritada özel pinlerle gösterimi, kuş uçuşu/yürüme mesafesi, tahmini yürüme süresi ve tek dokunuşla yol tarifi başlatma.

### 3.8. Gelişmiş Tesbihmatik (Zikirmatik)
- Hazır tesbihatlar, Esmaü'l-Hüsna, *Dualar ve Zikirler* virdleri ve sınırsız özel zikir ekleme.
- **Zincirleme Namaz Tesbihatı:** $33$ Sübhanallah -> $33$ Elhamdülillah -> $33$ Allahu Ekber otomatik geçiş modu.
- **Gözü Kapalı OLED Gece Modu:** Tam siyah ekranda herhangi bir noktaya dokunarak sayım, tok tesbih sesi veya mikro-titreşim, $33$'lük devirde farklı titreşim, yanlışlıkla sıfırlama kilidi, anlık veritabanı kaydı ve günlük/aylık zikir istatistikleri.

### 3.9. İslam'daki Önemli Gün ve Geceler Takvimi
- Diyanet uyumlu Hicri-Miladi takvim ($\pm 2$ gün manuel Hicri ayar dahil), Üç Aylar, Kandiller, Ramazan, Kadir Gecesi, Arefe, Bayramlar ve Aşure Günü için kalan gün sayaçları; her özel gün için anlamı, tavsiye edilen ibadetler ve o geceye mahsus dualar rehberi.

### 3.10. İleri Tarihli ve Vakitsel Akıllı Alarmlar
1. **İleri Tarihli Sabit & Hicri Alarmlar:** Belirli bir Miladi veya Hicri tarih/saat için tek seferlik veya tekrarlı alarmlar (ör. Cuma Kehf Suresi hatırlatması, Arefe oruç niyeti).
2. **Namaz Vaktine Göreli (Dinamik Kayan) Alarmlar:** Her gün değişen güneş/imsak saatlerine otomatik uyum sağlayan alarmlar (ör. *"İmsaktan $45\text{ dk}$ önce Teheccüd/Sahur"*, *"Güneşten $50\text{ dk}$ sonra İşrak"*, *"Akşamdan $20\text{ dk}$ sonra Evvabin ve dua dersi"*).
3. **Sünnet Oruçları Hatırlatıcısı:** Pazartesi-Perşembe ve Hicri $13, 14, 15$. günler (Eyyâm-ı Bîyd) için akşamdan hatırlatma.

### 3.11. Bağlamsal Not Defteri ("Tefekkür Defterim")
- Klasörlü, renk etiketli, kontrol listeli Markdown not editörü.
- **Bağlamsal Bağlantı:** Bir Kur'an ayeti, *Dualar ve Zikirler* sayfası veya *İlmi Akış* kartı okunurken alınan not doğrudan o kaynağa bağlanır; nota dokunulduğunda ilgili kaynak sayfa açılır. Özel notlar için FaceID / Parmak İzi kilidi bulunur.

### 3.12. Sevilen Tamamlayıcı Araçlar
- **Kaza Namazı & Orucu Takipçisi:** Hesaplama sihirbazı, vakit bazlı düşüm ve tahmini bitiş tarihi projeksiyonu.
- **5 Vakit Namaz Tesbihatı Metinleri:** Namaz sonrası geleneksel tesbihat ve Aşr-ı Şerifler okuma ekranı.
- **Esmaü'l-Hüsna (99 İsim):** Sesli telaffuz, anlam ve Tesbihmatik'e aktarım kartları.
- **Zekat & Fitre Hesaplayıcı:** Altın ($80.18\text{ g}$ nisap), döviz, nakit ve ticari mal üzerinden adım adım net hesaplama.
- **Ramazan Özel Modu & Ortak Hatim:** Ramazan'da otomatik İmsakiye/İftar modu ve paylaşılabilir link ile 30 cüzlük aile/arkadaş ortak hatim takibi.

---

## 4. Yerel Veritabanı Şeması (Drift / SQLite + FTS5)

~~~sql
CREATE TABLE prayer_times_cache (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    location_id TEXT NOT NULL,
    gregorian_date TEXT NOT NULL,
    hijri_date TEXT NOT NULL,
    fajr TEXT NOT NULL,
    sunrise TEXT NOT NULL,
    dhuhr TEXT NOT NULL,
    asr TEXT NOT NULL,
    maghrib TEXT NOT NULL,
    isha TEXT NOT NULL,
    calculation_source TEXT NOT NULL,
    UNIQUE(location_id, gregorian_date)
);

CREATE TABLE ilmi_feed_items (
    id TEXT PRIMARY KEY,
    category TEXT NOT NULL, -- 'fikih'|'siyer'|'kelam'|'hadis'|'ayet'|'ozlu_soz'|'kitap_alintisi'|'tasavvuf'
    title TEXT,
    arabic_text TEXT,
    summary_body TEXT NOT NULL,
    detailed_commentary TEXT,
    source_reference TEXT NOT NULL,
    author_or_scholar TEXT,
    book_page_ref TEXT,
    reading_time_sec INTEGER DEFAULT 30,
    is_liked INTEGER DEFAULT 0,
    is_read INTEGER DEFAULT 0,
    published_at INTEGER NOT NULL
);

CREATE TABLE collections (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    color_hex TEXT NOT NULL,
    created_at INTEGER NOT NULL
);

CREATE TABLE saved_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    collection_id TEXT REFERENCES collections(id) ON DELETE CASCADE,
    target_type TEXT NOT NULL, -- 'ilmi_card' | 'erkam_dua_page' | 'quran_ayah'
    target_id TEXT NOT NULL,
    saved_at INTEGER NOT NULL,
    UNIQUE(collection_id, target_type, target_id)
);

CREATE TABLE erkam_dua_pages (
    page_number INTEGER PRIMARY KEY,
    chapter_title TEXT NOT NULL,
    sub_title TEXT,
    arabic_content TEXT,
    transliteration_tr TEXT,
    meaning_tr TEXT NOT NULL,
    virtue_and_source TEXT,
    recommended_count INTEGER,
    audio_asset_url TEXT,
    is_favorite INTEGER DEFAULT 0,
    last_read_at INTEGER
);

CREATE TABLE quran_surahs (
    surah_number INTEGER PRIMARY KEY,
    name_arabic TEXT NOT NULL,
    name_tr TEXT NOT NULL,
    meaning_tr TEXT NOT NULL,
    ayah_count INTEGER NOT NULL,
    revelation_place TEXT NOT NULL,
    start_page INTEGER NOT NULL,
    is_downloaded_offline INTEGER DEFAULT 0,
    downloaded_reciter_id TEXT,
    local_storage_bytes INTEGER DEFAULT 0
);

CREATE TABLE quran_ayahs (
    id INTEGER PRIMARY KEY,
    surah_number INTEGER NOT NULL REFERENCES quran_surahs(surah_number),
    ayah_number INTEGER NOT NULL,
    mushaf_page INTEGER NOT NULL,
    juz_number INTEGER NOT NULL,
    uthmani_text TEXT NOT NULL,
    translation_tr TEXT NOT NULL,
    short_tafsir_tr TEXT,
    is_sajdah INTEGER DEFAULT 0
);

CREATE TABLE dhikr_items (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    arabic_text TEXT,
    transliteration TEXT,
    meaning_tr TEXT,
    target_count INTEGER NOT NULL DEFAULT 33,
    current_count INTEGER NOT NULL DEFAULT 0,
    total_lifetime_count INTEGER NOT NULL DEFAULT 0,
    linked_erkam_page INTEGER REFERENCES erkam_dua_pages(page_number),
    sort_order INTEGER DEFAULT 0
);

CREATE TABLE smart_alarms (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    alarm_type TEXT NOT NULL, -- 'fixed_datetime' | 'prayer_relative' | 'hijri_recurring'
    fixed_timestamp INTEGER,
    anchor_prayer TEXT,
    offset_minutes INTEGER,
    hijri_days_csv TEXT,
    weekdays_csv TEXT,
    linked_route TEXT,
    sound_id TEXT NOT NULL,
    is_enabled INTEGER DEFAULT 1
);

CREATE TABLE user_notes (
    id TEXT PRIMARY KEY,
    folder_name TEXT DEFAULT 'Genel',
    title TEXT NOT NULL,
    markdown_body TEXT NOT NULL,
    linked_entity_type TEXT,
    linked_entity_id TEXT,
    is_locked_biometric INTEGER DEFAULT 0,
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL
);

CREATE TABLE qada_tracker (
    prayer_type TEXT PRIMARY KEY,
    remaining_count INTEGER NOT NULL DEFAULT 0,
    completed_count INTEGER NOT NULL DEFAULT 0,
    daily_target INTEGER NOT NULL DEFAULT 1,
    updated_at INTEGER NOT NULL
);

CREATE VIRTUAL TABLE global_search_fts USING fts5(
    entity_type,
    entity_id,
    title,
    searchable_text
);
~~~

---

## 5. Proje Dizin Ağacı ve Veri Tohumlama (Sıfır-Token Veri Yükleme)

- **Tohum Veri Kuralı (`SeedLoader`):** Ajan `assets/seed_data/` içine yalnızca **şemayı doğrulayan 3-5 satırlık örnek JSON** (`erkam_dualar_sample.json`, `quran_sample.json`, `ilmi_feed_sample.json`) oluşturur ve ilk açılışta bunları SQLite + FTS5 tablolarına toplu yazan (`batch insert`) hızlı `SeedLoaderService` sınıfını kodlar. Tam veri paketleri aynı JSON formatında klasöre bırakıldığında tek satır kod değiştirmeden otomatik yüklenir.

~~~text
sukun_app/
├── GEMINI.md                  # Bölüm 0.1'deki ~25 satırlık hafif sistem kuralı
├── PROJECT_SPEC.md            # Bu ana spesifikasyon dosyası
├── STATE.md                   # Fazlar arası 30 satırlık durum özeti (ajan günceller)
├── .geminiignore              # Bölüm 0.2'deki bağlam filtresi
├── assets/
│   ├── fonts/                 # UthmanicHafs, Amiri, PlusJakartaSans, Literata
│   ├── audio/                 # Makamlı ezan ve tesbih sesleri
│   └── seed_data/             # JSON/SQLite içerik paketleri (ajan taramasından hariç)
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── theme/             # Nur, Karbon, Sepya temaları ve vakit gradyanları
│   │   ├── ui_kit/            # 6 ortak UI bileşeni (Bölüm 2.3)
│   │   ├── database/          # Drift tabloları, FTS5 arama ve SeedLoaderService
│   │   ├── router/            # GoRouter ve deep-link rotaları
│   │   ├── notifications/     # Ezan oynatıcı ve vakitsel alarm planlayıcı
│   │   └── widgets_bridge/    # iOS/Android native widget veri senkronizasyonu
│   └── features/
│       ├── prayer_times/      # Vakit motoru, güneş yayı, kerahat, seferilik
│       ├── ilmi_feed/         # 8 kategorili sosyal akış, paylaşım stüdyosu, koleksiyonlar
│       ├── dua_book_erkam/    # Erkam "Dualar ve Zikirler" okuyucu, sayfa favorileri
│       ├── quran/             # Mushaf/Meal görünümü, çevrimdışı sure/ses indirici, hatim
│       ├── qibla_mosques/     # Sensör füzyonlu Kıble, AR, Google Maps yakın camiler
│       ├── tasbih/            # Zincirleme tesbihat, gözü kapalı OLED zikirmatik
│       ├── islamic_calendar/  # Dini gün ve geceler takvimi ve ibadet rehberi
│       ├── smart_alarms/      # İleri tarihli, Hicri ve vakte göreli alarmlar
│       ├── notes/             # Bağlamsal Markdown notlar ve biyometrik kilit
│       └── tools/             # Kaza takibi, Esmaül Hüsna, Zekat, 5 vakit tesbihat
├── ios/SukunWidgets/          # SwiftUI WidgetKit & ActivityKit (Dynamic Island)
└── android/.../widgets/       # Kotlin Jetpack Glance & ExactAlarm alarmları
~~~

---

## 6. 7 Fazlı Kota Dostu Uygulama Planı ve Hazır Faz Komutları

> **Nasıl Uygulanır?** Her faz için aşağıdaki önerilen modeli seçin, ilgili komutu yapıştırın, ajan tek geçişte fazı bitirip `STATE.md` dosyasını güncellediğinde **yeni bir sohbet penceresi** açarak bir sonraki faza geçin.

| Faz | Kapsam | Önerilen Antigravity Modu | Tahmini Kota Etkisi |
| :--- | :--- | :--- | :--- |
| **Faz 1** | Altyapı, Tüm Drift Tabloları (`build_runner` tek sefer!), "Nur & Karbon" Teması ve 6 Ortak UI Bileşeni | **Planning Mode (Pro)** | Orta (Tüm temel tek seferde kurulur) |
| **Faz 2** | Namaz Vakti Motoru, Kerahat, Seferilik, Ana Ekran ve Ezan Bildirimleri | **Fast Mode (Flash)** | Çok Düşük |
| **Faz 3** | "İlmi Akış" (8 Kategori, Swipe & Liste), Koleksiyonlar ve Görsel Paylaşım Stüdyosu | **Fast Mode (Flash)** | Çok Düşük (`ui_kit` tekrar kullanılır) |
| **Faz 4** | Erkam *Dualar ve Zikirler* Kitaplığı + Kur'an-ı Kerim ve Çevrimdışı Sure/Ses İndirici | **Fast Mode (Flash)** | Çok Düşük (Sadece okuyucu & indirici motor) |
| **Faz 5** | Hassas Kıble Pusulası (AR + Harita), Yakın Camiler ve OLED Tesbihmatik | **Planning (Kıble) -> Fast** | Düşük |
| **Faz 6** | Dini Günler, Vakitsel/İleri Tarihli Akıllı Alarmlar, Bağlamsal Notlar ve Ekstra Araçlar | **Fast Mode (Flash)** | Çok Düşük |
| **Faz 7** | iOS `WidgetKit`/`ActivityKit`, Android `Jetpack Glance` ve Widget Tasarım Stüdyosu | **Planning Mode (Pro)** | Orta (Native Swift/Kotlin köprüsü) |

### Kopyala-Yapıştır Başlangıç Komutları

**Faz 1 Başlangıç Komutu (İlk Oturum):**
~~~text
@PROJECT_SPEC.md dosyasının yalnızca Bölüm 1, 2, 4 ve 5'ini oku. Tek geçişte (single-pass) ara onay sormadan:
1) Flutter proje iskeletini, GoRouter yapısını ve Bölüm 4'teki tüm Drift + FTS5 tablolarını tek seferde oluşturup build_runner'ı bir kez çalıştır, SeedLoaderService'i ve küçük örnek JSON şemalarını kur.
2) Bölüm 2'deki "Nur & Karbon" (Karbon, Nur, Sepya + dinamik gökyüzü gradyanları) tema motorunu ve Bölüm 2.3'teki 6 ortak ui_kit bileşenini eksiksiz kodla.
3) `flutter analyze --no-pub --no-fatal-infos` ve `flutter test --reporter compact` ile doğrula, @STATE.md dosyasını oluşturup özeti en fazla 5 maddede yaz.
~~~

**Faz 2-7 İçin Standart Yeni Oturum Komutu (Sadece Faz Numarasını Değiştirin):**
~~~text
Önce @STATE.md dosyasını ve @PROJECT_SPEC.md içinde yalnızca [FAZ X] kapsamındaki ilgili modül başlıklarını oku; diğer bölümleri ve mevcut tüm kod ağacını gereksiz yere tarama. `lib/core/ui_kit/` bileşenlerini yeniden kullanarak [FAZ X] modüllerini tek geçişte (single-pass) eksiksiz kodla, birim testlerini yaz, `flutter analyze --no-pub --no-fatal-infos` ve `flutter test --reporter compact` sıfır hata verene kadar düzelt ve @STATE.md dosyasını güncelle.
~~~