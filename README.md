# 🌿 DesaWisata Digital

> **Platform Informasi, Promosi, dan Reservasi Pengalaman Desa Wisata**  
> Proyek implementasi pengembangan perangkat lunak berbasis AI Workflow (Google Antigravity) dan Kolaborasi GitHub.

---

## 📌 1. Gambaran Umum & Masalah Pengguna

### Masalah Pengguna:
Informasi mengenai destinasi wisata desa, paket wisata edukasi/alam, jadwal kegiatan, dan produk khas UMKM warga selama ini masih tersebar dan belum tersaji dalam satu kanal terpadu yang mudah ditemukan oleh wisatawan.

### Solusi Produk:
Platform berbasis web terintegrasi yang menyediakan:
1. **Katalog Terpadu**: Destinasi wisata, aktivitas budaya/alam, dan paket tur desa.
2. **Showroom UMKM**: Profil pelaku usaha lokal beserta katalog produk kerajinan dan kuliner.
3. **Sistem Permintaan Reservasi**: Alur pemesanan jadwal kunjungan dengan validasi kapasitas kuota harian.
4. **Panel Pengelola**: Dashboard verifikasi manual bagi pengelola desa wisata untuk menerima/menolak reservasi dan memperbarui ketersediaan.

---

## 👥 2. Pengguna Utama & Alur Pengguna

| Pengguna | Peran & Alur Utama |
|---|---|
| **Wisatawan** | Menjelajahi destinasi, memfilter kategori & harga, membaca ulasan, melihat produk UMKM, dan mengirimkan permintaan reservasi. |
| **Pengelola Desa** | Mengelola konten destinasi & paket, memantau kuota ketersediaan, menerima permintaan reservasi, serta melakukan konfirmasi atau penolakan. |
| **Pelaku UMKM** | Menampilkan profil usaha, memajang katalog produk, dan menerima kontak/pertanyaan dari wisatawan. |

---

## 📦 3. Entitas Data Inti

Sistem dimodelkan dengan entitas data relasional berikut:
- **`Destination`**: Informasi objek wisata desa (nama, deskripsi, lokasi, banner, kategori).
- **`Activity`**: Rincian kegiatan di destinasi (trekking, membatik, bertani, dll).
- **`TourPackage`**: Paket tur gabungan beberapa aktivitas beserta harga dan kapasitas.
- **`Availability`**: Kalender kuota kapasitas pengunjung per tanggal/slot.
- **`ReservationRequest`**: Data pemesanan wisatawan (status: `PENDING`, `CONFIRMED`, `REJECTED`).
- **`MSME` & `Product`**: Data pelaku UMKM warga dan katalog barang olahan lokal.
- **`Review`**: Ulasan dan penilaian rating bintang dari wisatawan.

---

## 🏗️ 4. Struktur Repositori & Workflow GitHub

```text
desawisata/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── backend_task.yml       # Form tiket fitur/API backend
│   │   ├── frontend_task.yml      # Form tiket UI/komponen frontend
│   │   └── bug_report.yml         # Form pelaporan kendala/bug
│   └── PULL_REQUEST_TEMPLATE.md   # Format standar review PR tim
├── scripts/
│   └── setup_github_tickets.sh    # Script otomasi pembuatan label & 12 tiket awal
├── WORKFLOW_TICKET_GUIDE.md       # Panduan lengkap SOP tiket, branch, PR & KPI tim
└── README.md                      # Dokumentasi utama proyek
```

---

## 🎫 5. Matriks Tiket Backlog (BE & FE)

### 🛠️ Backend (BE)
- **`[BE-01]`**: Setup Database Schema & Migration Entitas Inti
- **`[BE-02]`**: API Katalog Destinasi & Paket Wisata (Filter & Detail)
- **`[BE-03]`**: API Profil UMKM & Katalog Produk Lokal Desa
- **`[BE-04]`**: API Alur Permintaan Reservasi & Validasi Kuota Harian
- **`[BE-05]`**: API Panel Admin: Verifikasi & Tindakan Reservasi
- **`[BE-06]`**: API Review & Rating Destinasi

### 🎨 Frontend (FE)
- **`[FE-01]`**: Setup Project, Tailwind Design System & Layout Utama
- **`[FE-02]`**: Halaman Katalog Destinasi Wisata & Filter Pencarian
- **`[FE-03]`**: Halaman Detail Destinasi, Fasilitas & Daftar Paket Wisata
- **`[FE-04]`**: Halaman Profil UMKM & Showroom Produk Lokal
- **`[FE-05]`**: Formulir Permintaan Reservasi & Validasi Kapasitas
- **`[FE-06]`**: Panel Pengelola: Dashboard & Manajemen Status Reservasi
- **`[FE-07]`**: Panel Pengelola: Form CRUD Destinasi & Pengaturan Kuota

---

## ⚡ 6. Langkah Singkat Menghubungkan ke GitHub

1. **Login ke GitHub CLI** (cukup 1 kali):
   ```bash
   gh auth login
   ```
2. **Buat Repository di GitHub**:
   ```bash
   gh repo create desawisata --public --source=. --remote=origin --push
   ```
3. **Generate Semua Label & Tiket Otomatis**:
   ```bash
   ./scripts/setup_github_tickets.sh
   ```
4. Buka tab **Issues** dan **Projects** di repositori GitHub Anda untuk mulai mengelola sprint tim!
