<<<<<<< HEAD
# FoodieQuest
=======

````md
# 🍽️ FoodieQuest

FoodieQuest adalah aplikasi Flutter untuk menampilkan resep makanan dan galeri foto makanan dengan backend Supabase.

---

## 🚀 Cara Menjalankan Aplikasi

### 1. Prasyarat
Pastikan sudah terinstall:
- Flutter SDK
- Dart SDK
- Google Chrome (untuk Web)
- Android Studio / Emulator (untuk Android)

Cek Flutter:
```bash
flutter doctor
````

---

### 2. Clone Repository

```bash
git clone https://github.com/WildanDevanata/FoodieQuest.git
cd FoodieQuest
```

---

### 3. Install Dependencies

```bash
flutter pub get
```

---

### 4. Konfigurasi Supabase

Buka file berikut:

```text
lib/services/supabase_service.dart
```

Isi dengan kredensial Supabase kamu:

```dart
static const String supabaseUrl = 'https://YOUR_PROJECT_ID.supabase.co';
static const String supabaseAnonKey = 'YOUR_ANON_PUBLIC_KEY';
```

---

### 5. Setup Supabase (Wajib)

Pastikan di Supabase:

* Tabel dibuat: `recipes`, `food_photos`, `favorites`
* Storage bucket: `food-photos`
* Bucket di-set **Public**
* Policy:

  * Public read data
  * Anonymous upload ke storage

---

### 6. Menjalankan Aplikasi

#### ▶️ Jalankan di Web

```bash
flutter run -d chrome
```

#### ▶️ Jalankan di Android

```bash
flutter run
```

---

### 7. Build Aplikasi (Opsional)

#### Build Web

```bash
flutter build web
```

#### Build APK Android

```bash
flutter build apk
```

---

## ⚠️ Catatan

* Project ini menggunakan Supabase tanpa autentikasi (anonymous access).
* Cocok untuk pembelajaran dan demo aplikasi.

---

## 👤 Author

Wildan Devanata
GitHub: [https://github.com/WildanDevanata](https://github.com/WildanDevanata)

```

---

### ✅ Checklist README
- ✔ Satu file `.md`
- ✔ Bisa langsung dipakai
- ✔ Fokus ke cara menjalankan program
- ✔ Markdown valid GitHub

Kalau mau, aku bisa:
- Tambahkan **Troubleshooting error Flutter & Supabase**
- Buat versi **Bahasa Indonesia super singkat**
- Tambahkan **SQL setup Supabase di README**

Tinggal bilang mau yang mana 👍
```
>>>>>>> 60bf32b (Initial commit FoodieQuest)
