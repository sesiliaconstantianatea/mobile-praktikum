# Course Data Manager — Flutter & Supabase

**Mahasiswa:** Sesilia Constantiana Tea  
**NIM:** 2415051112

## Deskripsi Aplikasi

Course Data Manager adalah aplikasi mobile berbasis Flutter untuk menampilkan dan mengelola data kursus. Aplikasi ini menggunakan Supabase sebagai backend untuk menyimpan dan mengelola data kursus.

Fitur utama:
- Menampilkan daftar kursus.
- Melihat detail kursus.
- Menambahkan kursus baru.
- Mengubah data kursus.
- Menghapus kursus.
- Mengelola daftar favorit.
- Menangani error saat mengambil atau memproses data.

## Teknologi

- **Flutter & Dart** — pengembangan aplikasi.
- **Provider** — state management.
- **Repository Pattern** — abstraksi akses data.
- **Supabase** — backend dan database.
- **HTTP & JSON** — latihan integrasi REST API dan penanganan respons.
- **Flutter Test** — pengujian model, service, dan perilaku aplikasi.

## Arsitektur Aplikasi

Alur ketergantungan aplikasi:

`Screens & Widgets → Provider → Repository → Data Source / Service → Supabase`

Tanggung jawab setiap bagian:

- `models/`: mendefinisikan struktur data kursus.
- `screens/`: menampilkan halaman dan interaksi pengguna.
- `widgets/`: menyediakan komponen UI yang dapat digunakan kembali.
- `providers/`: mengelola state dan logika aplikasi.
- `repositories/`: memisahkan logika aplikasi dari detail akses data.
- `services/`: menangani komunikasi dengan Supabase atau REST API.

## Backend dan Database

Backend menggunakan Supabase. Aplikasi menginisialisasi koneksi melalui `supabase_flutter` dan mengakses data kursus melalui `CourseSupabaseService`.

Dokumentasi skema database tersedia di:

`docs/schema_database_supabase.md`

**Keamanan:** aplikasi klien hanya boleh menggunakan publishable key. Jangan menyimpan `service_role` key, secret key, password database, atau kredensial administratif di dalam aplikasi Flutter atau repositori publik. Terapkan Row Level Security (RLS) dan kebijakan akses yang sesuai pada tabel database.

## Persiapan

Pastikan perangkat pengembangan sudah memiliki:

- Flutter SDK.
- Dart SDK yang sesuai dengan versi Flutter.
- Android Studio atau VS Code dengan ekstensi Flutter.
- Koneksi internet.

## Cara Menjalankan

1. Clone repositori:

   ```bash
   git clone https://github.com/sesiliaconstantianatea/mobile-praktikum.git
   ```

2. Masuk ke folder proyek:

   ```bash
   cd mobile-praktikum
   ```

3. Unduh dependensi:

   ```bash
   flutter pub get
   ```

4. Pastikan konfigurasi Supabase yang diperlukan sudah tersedia.

5. Jalankan aplikasi pada emulator atau perangkat yang terhubung:

   ```bash
   flutter run
   ```

## Pengujian

Jalankan seluruh pengujian Flutter dengan perintah:

```bash
flutter test
```

Pengujian mencakup model kursus, pemetaan JSON, serta skenario error pada layanan API.

## Struktur Proyek

```text
lib/
├── models/
├── providers/
├── repositories/
├── screens/
├── services/
└── widgets/

docs/
└── schema_database_supabase.md

test/
├── course_api_mapping_test.dart
├── course_api_permission_test.dart
├── course_api_service_test.dart
├── course_api_validation_test.dart
├── course_model_test.dart
└── widget_test.dart
```

## Riwayat Praktikum

Repositori ini berisi tahapan pengembangan aplikasi, mulai dari pengenalan REST API, pemodelan data, state management, repository pattern, integrasi Supabase, operasi CRUD, hingga penanganan error dan penguatan keamanan dasar.
