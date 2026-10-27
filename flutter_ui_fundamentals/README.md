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

## Tahap 1 — Dokumentasi REST API

### 1. Informasi Endpoint

- **Nama API:** JSONPlaceholder
- **URL Endpoint:** https://jsonplaceholder.typicode.com/posts/1
- **HTTP Method:** GET
- **Status Code:** 200 OK
- **Format Response:** JSON

### 2. Struktur Response JSON

Endpoint mengembalikan data berupa satu objek JSON dengan empat field berikut:

| Field | Tipe Data | Keterangan |
|---|---|---|
| `userId` | Number | ID pengguna pemilik post |
| `id` | Number | ID post |
| `title` | String | Judul post |
| `body` | String | Isi post |

### 3. Contoh Response

```json
{
  "userId": 1,
  "id": 1,
  "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  "body": "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto"
}
```

### 4. Hasil Pengamatan

Endpoint berhasil dibuka melalui browser dan menampilkan respons dalam format JSON. Method yang digunakan adalah GET untuk mengambil data post berdasarkan ID.

JSONPlaceholder merupakan API dummy untuk latihan. Operasi penulisan data disimulasikan dan tidak disimpan secara permanen.

### 5. Bukti Praktikum

Screenshot respons endpoint disimpan sebagai bukti pengujian API pada Tahap 1.
Hasil pengujian: Endpoint GET /posts/1 berhasil mengembalikan data JSON dengan status HTTP 200.