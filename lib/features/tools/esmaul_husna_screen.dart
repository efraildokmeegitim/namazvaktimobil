import 'package:flutter/material.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/sukun_surface_card.dart';

class EsmaulHusnaItem {
  final int id;
  final String nameArabic;
  final String nameTr;
  final String meaningTr;
  final String virtueTr;

  const EsmaulHusnaItem({
    required this.id,
    required this.nameArabic,
    required this.nameTr,
    required this.meaningTr,
    required this.virtueTr,
  });
}

const List<EsmaulHusnaItem> kEsmaulHusnaList = [
  EsmaulHusnaItem(id: 1, nameArabic: 'الله', nameTr: 'Allah', meaningTr: 'Eşi ve benzeri olmayan, bütün kemâl sıfatları kendisinde toplayan en yüce isim.', virtueTr: 'Günde 1000 defa zikredenin kalbi marifet nurlarıyla dolar.'),
  EsmaulHusnaItem(id: 2, nameArabic: 'الرَّحْمَن', nameTr: 'Er-Rahmân', meaningTr: 'Dünyada inanan ve inanmayan bütün mahlûkâta merhamet eden.', virtueTr: 'Kalp katılığı ve unutkanlıktan kurtulmak için her namazdan sonra 100 defa okunur.'),
  EsmaulHusnaItem(id: 3, nameArabic: 'الرَّحِيم', nameTr: 'Er-Rahîm', meaningTr: 'Ahirette yalnızca müminlere sonsuz merhamet ve lütufta bulunan.', virtueTr: 'Maddi ve manevi rızık bolluğu için her gün 258 defa zikredilir.'),
  EsmaulHusnaItem(id: 4, nameArabic: 'المَلِك', nameTr: 'El-Melik', meaningTr: 'Bütün kâinatın mutlak hükümdarı, gerçek sahibi ve mâliki.', virtueTr: 'İtibar ve vakar sahibi olmak, fakirlikten kurtulmak için zeval vaktinde 121 defa okunur.'),
  EsmaulHusnaItem(id: 5, nameArabic: 'القُدُّوس', nameTr: 'El-Kuddûs', meaningTr: 'Her türlü noksanlıktan, ayıptan ve kusurdan tamamen münezzeh ve pâk olan.', virtueTr: 'Gönül temizliği ve vesveselerden arınmak için günde 170 defa okunur.'),
  EsmaulHusnaItem(id: 6, nameArabic: 'السَّلَام', nameTr: 'Es-Selâm', meaningTr: 'Kullarını her türlü tehlike, korku ve felaketten selâmete çıkaran.', virtueTr: 'Korkulardan emin olmak ve şifa bulmak için 131 veya 161 defa zikredilir.'),
  EsmaulHusnaItem(id: 7, nameArabic: 'المُؤْمِن', nameTr: 'El-Mü\'min', meaningTr: 'Gönüllerde iman ışığı uyandıran, güven veren ve sığınanları koruyan.', virtueTr: 'Düşman şerrinden ve hıyanetten korunmak için günde 137 defa zikredilir.'),
  EsmaulHusnaItem(id: 8, nameArabic: 'المُهَيْمِن', nameTr: 'El-Müheymin', meaningTr: 'Bütün varlıkları gözetip kollayan, himaye eden ve her hallerine şahit olan.', virtueTr: 'Sırların inkişafı ve kalbin aydınlanması için yatsıdan sonra 145 defa okunur.'),
  EsmaulHusnaItem(id: 9, nameArabic: 'العَزِيز', nameTr: 'El-Azîz', meaningTr: 'Mağlup edilmesi imkânsız olan, daima galip ve izzet sahibi.', virtueTr: 'İzzet, şeref ve rızık genişliği için sabah namazından sonra 40 gün 41 defa okunur.'),
  EsmaulHusnaItem(id: 10, nameArabic: 'الجَبَّار', nameTr: 'El-Cebbâr', meaningTr: 'Kırılanları onaran, eksikleri tamamlayan, iradesine karşı gelinemeyen.', virtueTr: 'Zulümden korunmak ve zor işlerin halli için günde 206 defa okunur.'),
  EsmaulHusnaItem(id: 11, nameArabic: 'المُتَكَبِّر', nameTr: 'El-Mütekebbir', meaningTr: 'Büyüklükte eşi olmayan, azamet ve kibriyâ sahibi tek hakiki varlık.', virtueTr: 'Hayırlı bir ömür ve izzet için her gün 662 defa okunur.'),
  EsmaulHusnaItem(id: 12, nameArabic: 'الخَالِق', nameTr: 'El-Hâlık', meaningTr: 'Bütün varlıkları yoktan var eden, yaratıcı.', virtueTr: 'Sıkıntılardan feraha çıkmak ve işlerde başarı için günde 731 defa okunur.'),
  EsmaulHusnaItem(id: 13, nameArabic: 'البَارِئ', nameTr: 'El-Bâri\'', meaningTr: 'Her şeyi kusursuz, intizamlı ve birbirine uygun olarak yaratan.', virtueTr: 'Maddi ve ruhi hastalıklardan şifa bulmak için günde 214 defa zikredilir.'),
  EsmaulHusnaItem(id: 14, nameArabic: 'المُصَوِّر', nameTr: 'El-Musavvir', meaningTr: 'Mahlûkâta en güzel sureti, biçimi ve özellikleri veren.', virtueTr: 'Zihnin açılması ve güzel ahlak için günde 336 defa okunur.'),
  EsmaulHusnaItem(id: 15, nameArabic: 'الغَفَّار', nameTr: 'El-Gaffâr', meaningTr: 'Kullarının günahlarını örten, bağışlayan ve cezalandırmaktan vazgeçen.', virtueTr: 'Bağışlanma ve günahlardan arınmak için Cuma namazı sonrası 100 defa okunur.'),
  EsmaulHusnaItem(id: 16, nameArabic: 'القَهَّار', nameTr: 'El-Kahhâr', meaningTr: 'Her şeye boyun eğdiren, mutlak galebe ve hâkimiyet sahibi.', virtueTr: 'Nefsin hevalarını kırmak ve zalimlerin şerrinden korunmak için 306 defa okunur.'),
  EsmaulHusnaItem(id: 17, nameArabic: 'الوَهَّاب', nameTr: 'El-Vehhâb', meaningTr: 'Karşılıksız, sebepsiz ve hesapsız bolca ihsan ve nimet bahşeden.', virtueTr: 'Rızık ve zenginlik için secdede 7 veya 14 defa dua ile zikredilir.'),
  EsmaulHusnaItem(id: 18, nameArabic: 'الرَّزَّاق', nameTr: 'Er-Rezzâk', meaningTr: 'Yaratılmış bütün canlıların maddî ve manevî rızkını veren.', virtueTr: 'Sabah namazından sonra 308 defa zikredenin rızık kapıları ardına kadar açılır.'),
  EsmaulHusnaItem(id: 19, nameArabic: 'الفَتَّاح', nameTr: 'El-Fettâh', meaningTr: 'Bütün hayır, rahmet ve hidayet kapılarını ardına kadar açan.', virtueTr: 'Kalp ferahlığı ve müşkillerin halli için sabah namazından sonra sağ el göğse konularak 71 defa okunur.'),
  EsmaulHusnaItem(id: 20, nameArabic: 'العَلِيم', nameTr: 'El-Alîm', meaningTr: 'Gizliyi ve açığı, geçmişi ve geleceği hakkıyla en iyi bilen.', virtueTr: 'İlim ve hikmet kapılarının açılması için her gün 150 defa zikredilir.'),
  EsmaulHusnaItem(id: 21, nameArabic: 'القَابِض', nameTr: 'El-Kâbıd', meaningTr: 'Dilediğinde rızkı ve canları daraltan, sıkan ve tutan.', virtueTr: 'Zulümden korunmak için 903 defa zikredilir.'),
  EsmaulHusnaItem(id: 22, nameArabic: 'البَاسِط', nameTr: 'El-Bâsıt', meaningTr: 'Dilediğine rızkı ve neşeyi yayan, genişleten ve bollaştıran.', virtueTr: 'Kuşluk namazından sonra eller semaya açılarak 10 defa okunur.'),
  EsmaulHusnaItem(id: 23, nameArabic: 'الخَافِض', nameTr: 'El-Hâfıd', meaningTr: 'Kibirlenenleri ve zalimleri alçaltan, zelil kılan.', virtueTr: 'Düşman ve zalim şerrinden korunmak için günde 1481 defa okunur.'),
  EsmaulHusnaItem(id: 24, nameArabic: 'الرَّافِع', nameTr: 'Er-Râfi\'', meaningTr: 'Mümin kullarını, tevazu gösterenleri yücelten ve yükselten.', virtueTr: 'Maddi-manevi makam ve mertebenin yükselmesi için gece yarısı 351 defa okunur.'),
  EsmaulHusnaItem(id: 25, nameArabic: 'المُعِزّ', nameTr: 'El-Mu\'ız', meaningTr: 'Dilediğine izzet, şeref, kuvvet ve itibar veren.', virtueTr: 'Halk arasında hürmet ve sevgi görmek için Pazartesi ve Cuma geceleri 140 defa okunur.'),
  EsmaulHusnaItem(id: 26, nameArabic: 'المُذِلّ', nameTr: 'El-Müzill', meaningTr: 'Zulmedenleri ve hakka başkaldıranları zelil ve perişan eden.', virtueTr: 'Düşman hilesinden ve hasetçilerden emin olmak için 75 defa okunup secdeye varılır.'),
  EsmaulHusnaItem(id: 27, nameArabic: 'السَّمِيع', nameTr: 'Es-Semî\'', meaningTr: 'Gizli ve aşikâr, kalpten geçenler dâhil her sesi ve duayı işiten.', virtueTr: 'Duaların kabulü ve kulak hastalıklarından şifa için Perşembe günü 180 defa zikredilir.'),
  EsmaulHusnaItem(id: 28, nameArabic: 'البَصِير', nameTr: 'El-Basîr', meaningTr: 'Karanlıkta dahi gizli-açık her şeyi en ince teferruatıyla gören.', virtueTr: 'Göz aydınlığı ve basiret nurları için Cuma namazından önce 100 veya 302 defa okunur.'),
  EsmaulHusnaItem(id: 29, nameArabic: 'الحَكَم', nameTr: 'El-Hakem', meaningTr: 'Mutlak adaletle hükmeden, hak ile bâtılı birbirinden ayıran.', virtueTr: 'Gece yarısı abdestli olarak 68 defa zikredenin kalbine hikmet pınarları akar.'),
  EsmaulHusnaItem(id: 30, nameArabic: 'العَدْل', nameTr: 'El-Adl', meaningTr: 'Hadsiz adalet sahibi, zulümden tamamen uzak olan.', virtueTr: 'Nefsin adalete yönelmesi ve insaflı olmak için Cuma gecesi 104 defa okunur.'),
  EsmaulHusnaItem(id: 31, nameArabic: 'اللَّطِيف', nameTr: 'El-Latîf', meaningTr: 'En ince ve gizli işleri bilen, kullarına sezilmez yollardan lütufta bulunan.', virtueTr: 'Müşkillerin çözümü ve rızık için her gün 129 defa "Yâ Latîf" zikredilir.'),
  EsmaulHusnaItem(id: 32, nameArabic: 'الخَبِير', nameTr: 'El-Habîr', meaningTr: 'Her şeyin iç yüzünden ve gizli hakikatinden haberdar olan.', virtueTr: 'Hayırlı neticelere ermek ve basiret için günde 812 defa okunur.'),
  EsmaulHusnaItem(id: 33, nameArabic: 'الحَلِيم', nameTr: 'El-Halîm', meaningTr: 'Cezalandırmakta acele etmeyen, yumuşaklıkla muamele eden, hilm sahibi.', virtueTr: 'Öfkeyi yenmek ve evde sükûnet bulmak için günde 88 defa zikredilir.'),
  EsmaulHusnaItem(id: 34, nameArabic: 'العَظِيم', nameTr: 'El-Azîm', meaningTr: 'Zat ve sıfatlarında akılların idrak edemeyeceği kadar yüce olan.', virtueTr: 'Korkulardan emin olmak ve hürmet görmek için günde 1020 defa okunur.'),
  EsmaulHusnaItem(id: 35, nameArabic: 'الغَفُور', nameTr: 'El-Gafûr', meaningTr: 'Bağışlaması hudutsuz, günahları örtüp yok sayan.', virtueTr: 'Ruhu sıkıntılardan arındırmak ve affa nail olmak için günde 1286 defa zikredilir.'),
  EsmaulHusnaItem(id: 36, nameArabic: 'الشَّكُور', nameTr: 'Eş-Şekûr', meaningTr: 'Az amele çok sevap ve mükâfat veren, şükreden kullarını nimetlendiren.', virtueTr: 'Bolluk, bereket ve vücut sıhhati için günde 526 defa okunur.'),
  EsmaulHusnaItem(id: 37, nameArabic: 'العَلِيّ', nameTr: 'El-Aliyy', meaningTr: 'İzzet, kudret ve şerefte dengi ve benzeri olmayan en yüce varlık.', virtueTr: 'Zihin açıklığı ve makamın yükselmesi için günde 110 defa okunur.'),
  EsmaulHusnaItem(id: 38, nameArabic: 'الكَبِير', nameTr: 'El-Kebîr', meaningTr: 'Azamet ve büyüklüğü kavranamayan, her şeyden büyük olan.', virtueTr: 'Borçtan kurtulmak ve hürmet görmek için günde 232 defa okunur.'),
  EsmaulHusnaItem(id: 39, nameArabic: 'الحَفِيظ', nameTr: 'El-Hafîz', meaningTr: 'Bütün mevcudatı zevalden ve tehlikelerden muhafaza eden.', virtueTr: 'Her türlü kaza, bela ve musibetten korunmak için günde 998 defa okunur.'),
  EsmaulHusnaItem(id: 40, nameArabic: 'المُقِيت', nameTr: 'El-Mukît', meaningTr: 'Bütün canlıların gıdasını ve azığını vaktinde ulaştıran.', virtueTr: 'Oruçluyken susuzluğu hissetmemek ve rızık için günde 550 defa okunur.'),
  EsmaulHusnaItem(id: 41, nameArabic: 'الحَسِيب', nameTr: 'El-Hasîb', meaningTr: 'Herkesin amellerinin hesabını eksiksiz gören, kullarına yeten.', virtueTr: 'Korkulardan kurtulmak ve ferahlık için sabah-akşam 77 defa okunur.'),
  EsmaulHusnaItem(id: 42, nameArabic: 'الجَلِيل', nameTr: 'El-Celîl', meaningTr: 'Celâl, azamet ve ululuk sıfatlarının tek sahibi.', virtueTr: 'Zalimlerin şerrinden emin olmak ve vakar sahibi olmak için günde 73 defa okunur.'),
  EsmaulHusnaItem(id: 43, nameArabic: 'الكَرِيم', nameTr: 'El-Kerîm', meaningTr: 'Keremi, cömertliği ve lütfu sonsuz, karşılıksız veren.', virtueTr: 'Yatağa girerken zikredenin ömrü bereketlenir, günde 270 defa okunur.'),
  EsmaulHusnaItem(id: 44, nameArabic: 'الرَّقِيب', nameTr: 'Er-Rakîb', meaningTr: 'Her an her şeyi murakabe eden, gözetleyen ve koruyan.', virtueTr: 'Kayıp eşyayı bulmak ve hafızayı kuvvetlendirmek için günde 312 defa okunur.'),
  EsmaulHusnaItem(id: 45, nameArabic: 'المُجِيب', nameTr: 'El-Mücîb', meaningTr: 'Kendisine dua ve iltica edenlerin niyazlarına icabet eden.', virtueTr: 'Duaların süratle kabul olması için günde 55 veya 3025 defa zikredilir.'),
  EsmaulHusnaItem(id: 46, nameArabic: 'الوَاسِع', nameTr: 'El-Vâsi\'', meaningTr: 'İlmi, rahmeti, kudreti ve lütfu bütün kâinatı kuşatan.', virtueTr: 'Rızık ve ömür genişliği, kalp inşirahı için günde 137 defa zikredilir.'),
  EsmaulHusnaItem(id: 47, nameArabic: 'الحَكِيم', nameTr: 'El-Hakîm', meaningTr: 'Her emir ve işinde hikmet bulunan, hiçbir şeyi boş yaratmayan.', virtueTr: 'Hikmet ve ilim sahibi olmak, zihni açmak için günde 78 defa zikredilir.'),
  EsmaulHusnaItem(id: 48, nameArabic: 'الوَدُود', nameTr: 'El-Vedûd', meaningTr: 'Kullarını çok seven ve salih kulları tarafından çok sevilen.', virtueTr: 'Aile içi muhabbet, sevgi ve hürmet için günde 20 veya 1000 defa okunur.'),
  EsmaulHusnaItem(id: 49, nameArabic: 'المَجِيد', nameTr: 'El-Mecîd', meaningTr: 'Şanı, şerefi ve keremi pek yüce olan.', virtueTr: 'Hastalıkların şifası ve rütbenin artması için günde 57 defa zikredilir.'),
  EsmaulHusnaItem(id: 50, nameArabic: 'البَاعِث', nameTr: 'El-Bâis', meaningTr: 'Ölüleri dirilten, kabirlerden çıkaran ve peygamberler gönderen.', virtueTr: 'İmanın kuvvetlenmesi ve gafletten uyanmak için yatarken 100 defa okunur.'),
  EsmaulHusnaItem(id: 51, nameArabic: 'الشَّهِيد', nameTr: 'Eş-Şehîd', meaningTr: 'Her yerde hazır ve nazır olan, her şeye şahit bulunan.', virtueTr: 'İsyankâr evlat ve eşin ıslahı için seher vakti 319 defa okunur.'),
  EsmaulHusnaItem(id: 52, nameArabic: 'الحَقّ', nameTr: 'El-Hakk', meaningTr: 'Varlığı hiç değişmeden duran, fiilen var olan hakiki ilah.', virtueTr: 'Hakkı bulmak ve bâtıldan korunmak için her gün 108 defa zikredilir.'),
  EsmaulHusnaItem(id: 53, nameArabic: 'default_Vekil', nameTr: 'El-Vekîl', meaningTr: 'Kendisine güvenenlerin işlerini en mükemmel şekilde neticelendiren.', virtueTr: 'Tevekkül ve musibetlerden selamete ermek için günde 66 defa okunur.'),
  EsmaulHusnaItem(id: 54, nameArabic: 'القَوِيّ', nameTr: 'El-Kaviyy', meaningTr: 'Kudreti sonsuz, hiçbir şey O\'nu yoramayan ve aciz bırakamayan.', virtueTr: 'Maddi-manevi güç ve zalim şerrinden korunmak için günde 116 defa okunur.'),
  EsmaulHusnaItem(id: 55, nameArabic: 'المَتِين', nameTr: 'El-Metîn', meaningTr: 'Kuvveti sarsılmaz, metanet ve kudret sahibi.', virtueTr: 'Kötü huylardan ve zayıflıktan kurtulmak için günde 500 defa okunur.'),
  EsmaulHusnaItem(id: 56, nameArabic: 'الوَلِيّ', nameTr: 'El-Veliyy', meaningTr: 'Müminlerin dostu ve yardımcısı olan, onları karanlıktan nura çıkaran.', virtueTr: 'Allah dostlarından olmak ve himaye görmek için günde 46 defa zikredilir.'),
  EsmaulHusnaItem(id: 57, nameArabic: 'الحَمِيد', nameTr: 'El-Hamîd', meaningTr: 'Bütün hamd ve senalara yegâne layık olan.', virtueTr: 'Güzel ahlak ve şükür ehli olmak için sabah namazından sonra 66 defa okunur.'),
  EsmaulHusnaItem(id: 58, nameArabic: 'المُحْصِي', nameTr: 'El-Muhsî', meaningTr: 'Kâinattaki her şeyin sayısını ve miktarını tek tek bilen.', virtueTr: 'Zekâ keskinliği ve hafıza kuvveti için günde 148 defa okunur.'),
  EsmaulHusnaItem(id: 59, nameArabic: 'المُبْدِئ', nameTr: 'El-Mübdi\'', meaningTr: 'Mahlûkâtı maddesiz ve örneksiz olarak baştan yaratan.', virtueTr: 'Başlanan her işte muvaffakiyet için günde 56 defa zikredilir.'),
  EsmaulHusnaItem(id: 60, nameArabic: 'المُعِيد', nameTr: 'El-Mu\'îd', meaningTr: 'Yaratılmışları öldükten sonra tekrar dirilten.', virtueTr: 'Elden çıkan şeylerin geri dönmesi ve kayıplar için 124 defa okunur.'),
  EsmaulHusnaItem(id: 61, nameArabic: 'المُحْيِي', nameTr: 'El-Muhyî', meaningTr: 'Hayat veren, dirilten ve can bağışlayan.', virtueTr: 'Hastalıkların şifası ve kalbin dirilmesi için günde 68 defa zikredilir.'),
  EsmaulHusnaItem(id: 62, nameArabic: 'المُمِيت', nameTr: 'El-Mümît', meaningTr: 'Canlıların eceli gelince canlarını alan, ölümü yaratan.', virtueTr: 'Kötü nefsi terbiye etmek için günde 490 defa zikredilir.'),
  EsmaulHusnaItem(id: 63, nameArabic: 'الحَيّ', nameTr: 'El-Hayy', meaningTr: 'Ezeli ve ebedi diri olan, hayatın kaynağı.', virtueTr: 'Sıhhat, uzun ve bereketli ömür için her gün 324 defa okunur.'),
  EsmaulHusnaItem(id: 64, nameArabic: 'القَيُّوم', nameTr: 'El-Kayyûm', meaningTr: 'Bütün varlıkları ayakta tutan, zatıyla kâim olan.', virtueTr: 'Unutkanlıktan kurtulmak ve rızık için günde 156 defa okunur.'),
  EsmaulHusnaItem(id: 65, nameArabic: 'default_Wacid', nameTr: 'El-Vâcid', meaningTr: 'İstediğini istediği anda bulan, hiçbir şeye muhtaç olmayan.', virtueTr: 'Kayıpların bulunması ve kalp kuvveti için günde 14 defa zikredilir.'),
  EsmaulHusnaItem(id: 66, nameArabic: 'المَاجِد', nameTr: 'El-Mâcid', meaningTr: 'Kadr-ü kıymeti, şan ve şerefi pek yüce ve cömertliği sonsuz.', virtueTr: 'Kalp nurlanması ve hidayet için günde 48 defa zikredilir.'),
  EsmaulHusnaItem(id: 67, nameArabic: 'الوٰاحِد', nameTr: 'El-Vâhid', meaningTr: 'Zatında, sıfatlarında ve fiillerinde asla ortağı olmayan bir ve tek.', virtueTr: 'Korkulardan emin olmak ve kalbin tevhidi için günde 63 defa okunur.'),
  EsmaulHusnaItem(id: 68, nameArabic: 'الصَّمَد', nameTr: 'Es-Samed', meaningTr: 'Herkesin kendisine muhtaç olduğu, kendisi ise hiçbir şeye muhtaç olmayan.', virtueTr: 'Kimseye muhtaç olmamak için seher vakti 134 defa zikredilir.'),
  EsmaulHusnaItem(id: 69, nameArabic: 'القَادِر', nameTr: 'El-Kâdir', meaningTr: 'Dilediğini dilediği gibi yapmaya gücü yeten mutlak kudret sahibi.', virtueTr: 'Zor işleri başarmak için günde 305 defa zikredilir.'),
  EsmaulHusnaItem(id: 70, nameArabic: 'المُقْتَدِر', nameTr: 'El-Muktedir', meaningTr: 'Kudreti altında her şeyin tasarruf edildiği üstün kuvvet sahibi.', virtueTr: 'Uykudan kalkınca 7 defa zikredenin işleri kolaylaşır; günde 744 defa okunur.'),
  EsmaulHusnaItem(id: 71, nameArabic: 'المُقَدِّم', nameTr: 'El-Mukaddim', meaningTr: 'Dilediğini öne alan, mertebesini yükselten.', virtueTr: 'Sınavlarda ve hayırlı işlerde öne geçmek için günde 184 defa okunur.'),
  EsmaulHusnaItem(id: 72, nameArabic: 'المُؤَخِّر', nameTr: 'El-Muahhir', meaningTr: 'Dilediğini geriye bırakan, tehir eden.', virtueTr: 'Kötü alışkanlıkları geride bırakmak için günde 846 defa okunur.'),
  EsmaulHusnaItem(id: 73, nameArabic: 'الأَوَّل', nameTr: 'El-Evvel', meaningTr: 'Varlığının başlangıcı olmayan, her şeyden önce var olan ezeli.', virtueTr: 'Hayırlı evlat ve işlerin hayırla başlaması için Cuma günleri 37 defa okunur.'),
  EsmaulHusnaItem(id: 74, nameArabic: 'الآخِر', nameTr: 'El-Âhir', meaningTr: 'Varlığının sonu olmayan, her şey yok olduktan sonra bâki kalan ebedi.', virtueTr: 'Ömrün hüsn-i hâtime ile son bulması için günde 801 defa okunur.'),
  EsmaulHusnaItem(id: 75, nameArabic: 'الظَّاهِر', nameTr: 'Ez-Zâhir', meaningTr: 'Varlığı sayısız delillerle apaçık görünen, kudretiyle zahir olan.', virtueTr: 'Gizli ilimlerin ve basiretin açılması için işrak vaktinde 1106 defa okunur.'),
  EsmaulHusnaItem(id: 76, nameArabic: 'البَاطِن', nameTr: 'El-Bâtın', meaningTr: 'Akılların idrakinden gizli olan, zatının hakikati bilinemeyen.', virtueTr: 'Gönül huzuru ve iç alemin nurlanması için günde 62 defa okunur.'),
  EsmaulHusnaItem(id: 77, nameArabic: 'الوٰالِي', nameTr: 'El-Vâlî', meaningTr: 'Bütün kâinatı ve hadiseleri tek başına idare eden.', virtueTr: 'İşlerin yoluna girmesi ve afetlerden korunmak için günde 47 defa zikredilir.'),
  EsmaulHusnaItem(id: 78, nameArabic: 'المُتَعَالِي', nameTr: 'El-Müteâlî', meaningTr: 'Yaratılmışların sıfatlarından ve noksanlıklardan pek yüce olan.', virtueTr: 'Makam ve rütbece yükselmek için günde 540 defa okunur.'),
  EsmaulHusnaItem(id: 79, nameArabic: 'البَرّ', nameTr: 'El-Berr', meaningTr: 'İyilik ve ihsanı bol, kullarına şefkatle muamele eden.', virtueTr: 'Kötü huylardan arınmak ve felçten şifa için günde 202 defa okunur.'),
  EsmaulHusnaItem(id: 80, nameArabic: 'التَّوَّاب', nameTr: 'Et-Tevvâb', meaningTr: 'Tevbeleri kabul eden ve günahları bağışlayan.', virtueTr: 'Tevbelerin kabulü ve kalbin arınması için kuşluk vakti 409 defa okunur.'),
  EsmaulHusnaItem(id: 81, nameArabic: 'المُنْتَقِم', nameTr: 'El-Müntakim', meaningTr: 'Zalimlerden, adaleti çiğneyenlerden intikam alan ve cezalandıran.', virtueTr: 'Zalimlerin zulmünden korunmak için günde 630 defa okunur.'),
  EsmaulHusnaItem(id: 82, nameArabic: 'العَفُوّ', nameTr: 'El-Afüvv', meaningTr: 'Kullarının günahlarını tamamen silip yok eden, affı çok bol.', virtueTr: 'Rızık bereketi ve affa nail olmak için günde 156 defa okunur.'),
  EsmaulHusnaItem(id: 83, nameArabic: 'الرَّءُوف', nameTr: 'Er-Raûf', meaningTr: 'Pek şefkatli, merhametli ve kullarını esirgeyen.', virtueTr: 'İnsanların şefkat ve sevgisini kazanmak için günde 286 defa zikredilir.'),
  EsmaulHusnaItem(id: 84, nameArabic: 'مَالِكُ المُلْك', nameTr: 'Mâlikü\'l-Mülk', meaningTr: 'Mülkün ebedî ve hakiki tek sahibi.', virtueTr: 'Maddi-manevi mülk ve zenginlik için günde 212 defa okunur.'),
  EsmaulHusnaItem(id: 85, nameArabic: 'ذُو الجَلَالِ وَالإِكْرَام', nameTr: 'Zü\'l-Celâli ve\'l-İkrâm', meaningTr: 'Hem büyüklük ve azamet hem de kerem ve ihsan sahibi.', virtueTr: 'İşlerin kolaylaşması ve duaların kabulu için günde 1155 defa zikredilir.'),
  EsmaulHusnaItem(id: 86, nameArabic: 'المُقْسِط', nameTr: 'El-Muksit', meaningTr: 'Bütün işlerini denk, dengeli ve mutlak adaletle yapan.', virtueTr: 'Vesveseden kurtulmak ve adil olmak için günde 209 defa okunur.'),
  EsmaulHusnaItem(id: 87, nameArabic: 'الجَامِع', nameTr: 'El-Câmi\'', meaningTr: 'Kıyamet günü mahlûkâtı bir araya toplayan, bütün zıtlıkları cem eden.', virtueTr: 'Kayıp eşyayı bulmak ve ayrılanların birleşmesi için günde 114 defa zikredilir.'),
  EsmaulHusnaItem(id: 88, nameArabic: 'الغَنِيّ', nameTr: 'El-Ganiyy', meaningTr: 'Hiçbir şeye ihtiyacı olmayan, sonsuz zenginlik sahibi.', virtueTr: 'Büyük servet ve gönül zenginliği için günde 1060 defa okunur.'),
  EsmaulHusnaItem(id: 89, nameArabic: 'المُغْنِي', nameTr: 'El-Mugnî', meaningTr: 'Dilediğini zengin kılan, ihtiyacını gideren.', virtueTr: 'Fakirlikten kurtulmak için Cuma geceleri 1100 defa okunur.'),
  EsmaulHusnaItem(id: 90, nameArabic: 'المَانِع', nameTr: 'El-Mâni\'', meaningTr: 'İstemediği şeylerin meydana gelmesine mani olan, engelleyen.', virtueTr: 'Kaza ve belalardan korunmak için günde 161 defa zikredilir.'),
  EsmaulHusnaItem(id: 91, nameArabic: 'الضَّارّ', nameTr: 'Ed-Dârr', meaningTr: 'Hikmeti gereği elem ve zarar verici şeyleri de yaratan.', virtueTr: 'Zarar veren şeylerin şerrinden korunmak için Cuma geceleri 1001 defa okunur.'),
  EsmaulHusnaItem(id: 92, nameArabic: 'النَّافِع', nameTr: 'En-Nâfi\'', meaningTr: 'Bütün mahlûkâta faydalı ve hayırlı şeyleri ihsan eden.', virtueTr: 'Hayırlı kazanç, sıhhat ve ferahlık için günde 201 defa okunur.'),
  EsmaulHusnaItem(id: 93, nameArabic: 'النُّور', nameTr: 'En-Nûr', meaningTr: 'Alemleri nurlandıran, gönüllere hidayet ışığı veren.', virtueTr: 'Kalbin ve yüzün nurlanması için günde 256 defa okunur.'),
  EsmaulHusnaItem(id: 94, nameArabic: 'الهَادِي', nameTr: 'El-Hâdî', meaningTr: 'Kullarına doğru yolu gösteren, hidayete erdiren.', virtueTr: 'Hidayet ve sırat-ı müstakim üzere sebat için günde 20 veya 400 defa zikredilir.'),
  EsmaulHusnaItem(id: 95, nameArabic: 'البَدِيع', nameTr: 'El-Bedî\'', meaningTr: 'Sanatında eşsiz, örneksiz ve benzersiz güzellikte yaratan.', virtueTr: 'İlim, sanat ve hikmette ilerlemek için günde 86 defa zikredilir.'),
  EsmaulHusnaItem(id: 96, nameArabic: 'البَاقِي', nameTr: 'El-Bâkî', meaningTr: 'Varlığının sonu olmayan, ebediyen var olan.', virtueTr: 'Sıhhat, uzun ömür ve kederden kurtulmak için günde 113 defa okunur.'),
  EsmaulHusnaItem(id: 97, nameArabic: 'الوٰارِث', nameTr: 'El-Vâris', meaningTr: 'Mülkün gerçek ve nihai tek sahibi, her şey fanî olduktan sonra kalan.', virtueTr: 'Uzun ömür, mal bereketi ve hidayet için güneş doğarken 707 defa okunur.'),
  EsmaulHusnaItem(id: 98, nameArabic: 'الرَّشِيد', nameTr: 'Er-Reşîd', meaningTr: 'Bütün işleri en doğru hedefe ulaştıran, kılavuza ihtiyacı olmayan mürşid.', virtueTr: 'Doğru kararlar almak ve pişman olmamak için yatsıdan sonra 514 defa okunur.'),
  EsmaulHusnaItem(id: 99, nameArabic: 'الصَّبُور', nameTr: 'Es-Sabûr', meaningTr: 'Çok sabırlı, cezalandırmada acele etmeyip mühlet veren.', virtueTr: 'Sabır, sebat ve zorluklara mukavemet için güneş doğmadan 298 defa zikredilir.'),
];

class EsmaulHusnaScreen extends StatefulWidget {
  const EsmaulHusnaScreen({super.key});

  @override
  State<EsmaulHusnaScreen> createState() => _EsmaulHusnaScreenState();
}

class _EsmaulHusnaScreenState extends State<EsmaulHusnaScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filtered = kEsmaulHusnaList.where((item) {
      if (_searchQuery.isEmpty) return true;
      final q = _searchQuery.toLowerCase();
      return item.nameTr.toLowerCase().contains(q) ||
          item.nameArabic.contains(q) ||
          item.meaningTr.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Esmâü\'l-Hüsnâ (99 İsim)', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val.trim()),
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'İsim, anlam veya Arapça ara...',
                hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
                prefixIcon: const Icon(Icons.search, color: SukunColors.goldAccent, size: 20),
                filled: true,
                fillColor: SukunColors.carbonCardSurface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = filtered[index];
                return SukunSurfaceCard(
                  enableGlass: true,
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: SukunColors.goldAccent.withValues(alpha: 0.15),
                                  border: Border.all(color: SukunColors.goldAccent.withValues(alpha: 0.4)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${item.id}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: SukunColors.goldAccent, fontSize: 12),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                item.nameTr,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                          Text(
                            item.nameArabic,
                            style: SukunTheme.arabicQuranStyle(fontSize: 22, color: SukunColors.goldAccent),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.meaningTr,
                        style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: SukunColors.emeraldPrimary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: SukunColors.emeraldPrimary.withValues(alpha: 0.25)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded, size: 14, color: SukunColors.emeraldPrimary),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                item.virtueTr,
                                style: const TextStyle(color: Colors.white, fontSize: 11, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
