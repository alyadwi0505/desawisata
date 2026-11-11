# 🚀 Panduan Workflow Tiketing & Kolaborasi GitHub: DesaWisata Digital

Dokumen ini adalah acuan standar kerja (SOP) tim pengembangan **DesaWisata Digital** untuk divisi **Backend (BE)**, **Frontend (FE)**, dan **Product/UI-UX**.

---

## 1. Siklus Hidup Tiket (Ticketing Lifecycle & Kanban Board)

Setiap fitur atau perbaikan bug harus melalui alur Kanban Board (GitHub Projects) berikut:

```
[ 📥 Backlog ] ──► [ 📋 To Do ] ──► [ ⚙️ In Progress ] ──► [ 🔍 In Review (PR) ] ──► [ 🧪 QA / Test ] ──► [ ✅ Done ]
```

### Penjelasan Status:
1. **📥 Backlog**: Kumpulan ide, fitur, dan kebutuhan produk yang belum dijadwalkan masuk sprint aktif.
2. **📋 To Do (Sprint Active)**: Tiket yang sudah di-breakdown, memiliki estimasi story point, dan siap dikerjakan pada sprint berjalan.
3. **⚙️ In Progress**: Tiket yang sedang aktif dikerjakan oleh developer (maksimal 1 developer memegang 1-2 tiket aktif sekaligus untuk menjaga fokus).
4. **🔍 In Review (PR)**: Kode selesai dibuat di branch lokal, dipush, dan dibuatkan Pull Request (PR). Menunggu review dari minimal 1 rekan tim (peer review).
5. **🧪 QA / Testing**: Kode sudah lolos review, digabung ke branch staging/dev, dan diverifikasi apakah sesuai dengan *Acceptance Criteria* & rancangan Figma.
6. **✅ Done**: Tiket selesai, teruji, dan telah di-merge ke branch utama (`main`).

---

## 2. Standar Penamaan Branch & Commit

### A. Format Penamaan Branch
Format: `<tipe>/<divisi>-<nomor_tiket>-<deskripsi_singkat>`

Contoh:
- `feat/be-01-schema-destinasi`
- `feat/fe-02-katalog-filter`
- `fix/be-05-validasi-kapasitas-kuota`
- `chore/fe-setup-tailwind-base`

Tipe branch:
- `feat/`: Penambahan fitur baru.
- `fix/`: Perbaikan bug.
- `chore/`: Konfigurasi dependensi, linter, atau setup repo.
- `docs/`: Pembaruan dokumentasi.

### B. Format Pesan Commit (Conventional Commits)
Format: `<tipe>(<scope>): <pesan penjelasan>`

Contoh:
- `feat(be): add destination and tour package CRUD endpoints`
- `feat(fe): implement responsive filter bar for destination catalog`
- `fix(be): fix edge case where capacity check allows overbooking`
- `docs: update API contract for reservation request`

---

## 3. Matriks Pembagian Kerja (BE vs FE)

| ID Tiket | Divisi | Nama Fitur / Tugas | Scope & Output Utama |
|---|---|---|---|
| **BE-01** | Backend | Setup Database & Entity Schema | Model & migrasi data: `Destination`, `Activity`, `TourPackage`, `Availability`, `ReservationRequest`, `MSME`, `Product`, `Review`. |
| **BE-02** | Backend | API Katalog Destinasi & Paket | Endpoint `GET /api/destinations` dengan query filter (kategori, range harga, rating). |
| **BE-03** | Backend | API UMKM & Produk Lokal | Endpoint CRUD profil UMKM dan produk kerajinan/kuliner desa. |
| **BE-04** | Backend | API Permintaan Reservasi & Validasi Kuota | Validasi kapasitas ketersediaan tanggal, status awal `PENDING`, kalkulasi jumlah pengunjung. |
| **BE-05** | Backend | API Admin Verification Panel | Endpoint konfirmasi (`ACCEPTED`) atau penolakan (`REJECTED`) reservasi oleh pengelola. |
| **BE-06** | Backend | API Review & Rating | Pengiriman ulasan destinasi dan kalkulasi agregasi rating bintang. |
| **BE-07** | Backend | Seeding Initial Data Desa Wisata | Seed data dummy destinasi, paket, dan profil UMKM percontohan. |
| **FE-01** | Frontend | Project Setup & Design System Base | Setup layout utama, responsive navbar, footer, konfigurasi warna & font sesuai Figma. |
| **FE-02** | Frontend | Halaman Katalog & Filter Interaktif | Tampilan grid destinasi, pencarian keyword, dropdown filter kategori dan harga. |
| **FE-03** | Frontend | Halaman Detail Destinasi & Paket Wisata | Hero image banner, rincian aktivitas, fasilitas, daftar paket tur, dan ulasan. |
| **FE-04** | Frontend | Halaman Profil UMKM & Produk Desa | Showcase usaha warga desa, jam buka, galeri produk, dan nomor kontak. |
| **FE-05** | Frontend | Formulir Permintaan Reservasi | Form input tanggal, pemilih jumlah peserta, kalkulator estimasi harga, indikator kuota. |
| **FE-06** | Frontend | Panel Pengelola - Manajemen Reservasi | Tabel daftar reservasi masuk, filter status (Pending/Confirmed/Rejected), tombol aksi. |
| **FE-07** | Frontend | Panel Pengelola - CRUD Konten & Destinasi | Form tambah/edit informasi destinasi wisata, upload gambar, dan kuota harian. |

---

## 4. Cara Mengukur Kinerja Anggota Tim (Team Performance Metrics)

Untuk menjawab kebutuhan evaluasi manajemen proyek:
1. **Sprint Velocity & Burndown**: Mengukur persentase story points / tiket yang berhasil dipindahkan dari *To Do* ke *Done* dalam satu iterasi sprint.
2. **Pull Request Quality & Review Turnaround**:
   - Kecepatan memberikan review terhadap PR rekan kerja (< 24 jam).
   - Tingkat kedalaman review (memberikan masukan arsitektur, clean code, keamanan).
3. **Defect Leakage / Bug Rate**: Jumlah bug yang ditemukan pada tahap QA atau pasca-merge terkait kode yang ditulis anggota tersebut.
4. **Commit Hygiene & Disiplin Workflow**: Ketaatan menggunakan template tiket, penamaan branch yang rapi, dan deskripsi PR yang informatif.

---

## 5. Integrasi Antigravity dengan Figma untuk UI/UX

1. **Figma sebagai Single Source of Truth**:
   - Tim UI/UX menyusun token desain (warna, tipografi, grid system, varian tombol, dan komponen card).
   - Setiap tiket FE (`[FE]`) wajib mencantumkan tautan frame Figma spesifik.
2. **Pemanfaatan AI Antigravity**:
   - Antigravity membaca struktur visual dari Figma dan langsung mengonversinya menjadi kode komponen React/HTML/CSS responsif yang bersih.
   - Antigravity secara otomatis menangani *edge case* UI seperti *loading skeleton*, *empty state*, dan validasi form interaktif.
   - Hasil kode diverifikasi terhadap spesifikasi API dari tiket BE sehingga integrasi FE-BE berjalan tanpa *mismatch* tipe data.
