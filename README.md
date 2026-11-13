🍽️ Recipe App - Flutter
Flutter ile geliştirilmiş basit bir yemek tarifi uygulaması. API'den JSON verileri çekerek tarifleri listeler, favorilere ekleme ve detay görüntüleme özelliklerini sunar.

📱 Ekran Görüntüleri
Ana Sayfa	Favoriler	Detay
![HomePage](my_project/screenShots/Ekran%20görüntüsü%202026-11-13%20124120.png)  ![DetailPage](my_project/screenShots/Ekran%20görüntüsü%202026-11-13%20124148.png) ![Favorites](my_project/screenShots/Ekran%20görüntüsü%202026-11-13%20124139.png)

✨ Özellikler
🌐 API Entegrasyonu: JSON formatındaki tarif verilerini API'den çeker

📋 Ana Sayfa: Tüm tarifleri liste halinde gösterir

⭐ Favoriler: Beğendiğiniz tarifleri favorilere ekleyip ayrı bir sayfada görüntüleyebilirsiniz

🔍 Detay Sayfası: Tariflere tıklayarak detaylı bilgilere (malzemeler, yapılışı vb.) erişebilirsiniz

🎨 Modern Arayüz: Kullanıcı dostu ve sade tasarım

🛠️ Kullanılan Teknolojiler
Flutter - UI framework

Dart - Programlama dili

HTTP - API istekleri için

JSON - Veri formatı

📂 Proje Yapısı
text
lib/
├── models/          # Veri modelleri
├── views/         # Uygulama sayfaları
│   ├── homeView.dart
│   ├── favorites_view.dart
│   └── recipe_detail_view.dart
├── services/        # API servisleri
└── main.dart        # Uygulama giriş noktası
🚀 Kurulum
Projeyi klonlayın:

bash
git clone https://github.com/kullaniciadi/recipe-app.git
Proje dizinine gidin:

bash
cd recipe-app
Bağımlılıkları yükleyin:

bash
flutter pub get
Uygulamayı çalıştırın:

bash
flutter run

🎯 Kullanım
Uygulama açıldığında ana sayfada API'den çekilen tarifler listelenir

Herhangi bir tarife tıklayarak detay sayfasına geçebilirsiniz

Favorilere eklemek istediğiniz tariflerin yanındaki favori butonuna tıklayabilirsiniz

Favoriler sekmesinden eklediğiniz tarifleri görüntüleyebilirsiniz
