# Course Explorer v2 - Mobile Architecture & State Management

**Mahasiswa:** Sesilia Constantiana Tea  
**NIM:** 2415051112  

## Arah Ketergantungan (Dependency Direction)
Arsitektur aplikasi mengikuti aliran data dan ketergantungan satu arah (*Unidirectional Data Flow*):
`Presentation Layer (Screens & Widgets)` -> `State Management (Providers)` -> `Domain/Data Layer (Repositories)` -> `Data Source (Services / JSON Assets)`

- **UI Layer** tidak pernah memanggil `rootBundle` atau `jsonDecode` secara langsung.
- **Service Layer** tidak pernah mengimpor atau memuat pustaka UI (`flutter/material.dart`).
- **Provider Layer** murni mengelola state dan business logic tanpa menyimpan objek `BuildContext`.

## Tanggung Jawab Struktur Folder (`lib/`)
- `models/`: Mendefinisikan struktur objek data (`Course.fromJson`) dengan tipe data terstruktur.
- `services/`: Menangani detail teknis pengambilan data mentah dari sumber data (`rootBundle` / REST API / DB).
- `repositories/`: Menyediakan lapisan abstraksi akses data untuk Provider agar independen dari detail data source.
- `providers/`: Mengelola state aplikasi (*async state* & *favorites*), mengeksekusi *business logic*, dan memanggil `notifyListeners()`.
- `screens/`: Menampilkan tata letak halaman utama (*Home*, *Courses*, *Favorites*, *Detail*) dan navigasi.
- `widgets/`: Menyediakan komponen UI reusable (seperti `CourseCard`) untuk menghindari duplikasi kode.