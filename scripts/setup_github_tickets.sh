#!/usr/bin/env bash
# Script otomatis untuk membuat Label dan Tiket Backlog BE/FE di GitHub Repository
# Pastikan sudah menjalankan: gh auth login

set -e

echo "🚀 Memulai inisialisasi Label dan Tiket GitHub untuk DesaWisata Digital..."

# 1. Cek login gh
if ! gh auth status > /dev/null 2>&1; then
  echo "❌ Anda belum login ke GitHub CLI."
  echo "👉 Silakan jalankan perintah: gh auth login"
  exit 1
fi

echo "✅ Terhubung ke GitHub!"

# 2. Buat Label Kategori & Prioritas
echo "🏷️  Membuat Label..."
gh label create "backend" --description "Tugas backend, API, & database" --color "1D76DB" --force
gh label create "frontend" --description "Tugas frontend, UI/UX, & integrasi" --color "0E8A16" --force
gh label create "priority:high" --description "Prioritas tinggi (MVP blocker)" --color "B60205" --force
gh label create "priority:medium" --description "Prioritas sedang (Fitur standar)" --color "FBCA04" --force
gh label create "priority:low" --description "Prioritas rendah (Penyempurnaan)" --color "C2E0C6" --force
gh label create "needs-review" --description "Menunggu review rekan tim" --color "D4C5F9" --force

echo "📋 Membuat Tiket Backend (BE)..."

gh issue create --title "[BE-01] Setup Database Schema & Migration Entitas Inti" \
  --label "backend,priority:high" \
  --body "### Domain: Database & Architecture
**User Story:**
Sebagai sistem pengelola data, dibutuhkan arsitektur basis data relasional untuk menampung entitas inti desa wisata.

**Entitas Terkait:**
- \`Destination\` (id, name, slug, description, location, category, banner_url)
- \`Activity\` (id, destination_id, title, duration_hours, price)
- \`TourPackage\` (id, destination_id, title, price, max_capacity, inclusions)
- \`Availability\` (id, package_id, date, quota, booked_slots)
- \`ReservationRequest\` (id, package_id, customer_name, customer_email, date, visitors, status: PENDING/CONFIRMED/REJECTED)
- \`MSME\` & \`Product\` (id, name, owner, contact, category, price)
- \`Review\` (id, destination_id, rating, comment)

**Acceptance Criteria:**
- [ ] Schema database terdefinisi dengan foreign key yang tepat
- [ ] Migration script berjalan sukses tanpa error
- [ ] Seeder awal siap diisi"

gh issue create --title "[BE-02] API Katalog Destinasi & Paket Wisata (Filter & Detail)" \
  --label "backend,priority:high" \
  --body "### Domain: Destination & TourPackage
**User Story:**
Sebagai wisatawan, saya membutuhkan endpoint untuk melihat katalog destinasi beserta opsi filter kategori dan detail paket.

**Spesifikasi Endpoint:**
- \`GET /api/v1/destinations\` (Query params: \`category\`, \`search\`, \`min_price\`, \`max_price\`)
- \`GET /api/v1/destinations/:id\` (Detail destinasi beserta aktivitas, paket, ulasan)
- \`GET /api/v1/packages/:id\` (Detail paket wisata & info kuota)

**Acceptance Criteria:**
- [ ] Pencarian keyword dan filter kategori berfungsi
- [ ] Response menyertakan list paket wisata dan fasilitas
- [ ] Unit test endpoint mengembalikan status 200"

gh issue create --title "[BE-03] API Profil UMKM & Katalog Produk Lokal Desa" \
  --label "backend,priority:medium" \
  --body "### Domain: MSME & Product
**User Story:**
Sebagai pelaku UMKM desa, saya membutuhkan endpoint untuk menampilkan profil usaha lokal dan katalog produk olahan/kerajinan.

**Spesifikasi Endpoint:**
- \`GET /api/v1/msmes\` (Daftar UMKM desa wisata)
- \`GET /api/v1/msmes/:id/products\` (Daftar produk tiap UMKM)
- \`POST /api/v1/msmes/:id/inquiry\` (Permintaan kontak/informasi produk)

**Acceptance Criteria:**
- [ ] Daftar produk berhasil ditampilkan per UMKM
- [ ] Nomor kontak WhatsApp/telepon tervalidasi"

gh issue create --title "[BE-04] API Alur Permintaan Reservasi & Validasi Kuota Harian" \
  --label "backend,priority:high" \
  --body "### Domain: ReservationRequest & Availability
**User Story:**
Sebagai wisatawan, saya ingin mengirim permintaan reservasi paket wisata dengan validasi kapasitas otomatis agar tidak terjadi overbooking.

**Spesifikasi Endpoint:**
- \`POST /api/v1/reservations\`
- **Payload:**
  \`\`\`json
  {
    \"package_id\": 1,
    \"customer_name\": \"Budi Santoso\",
    \"customer_email\": \"budi@example.com\",
    \"customer_phone\": \"08123456789\",
    \"visit_date\": \"2026-12-01\",
    \"visitors_count\": 4,
    \"notes\": \"Bawa balita 1 orang\"
  }
  \`\`\`

**Business Logic & Validasi:**
- Cek ketersediaan kuota pada tanggal yang dipilih
- Jika kuota tersisa < jumlah pengunjung: kembalikan 400 Bad Request
- Status awal reservasi diset ke \`PENDING\`

**Acceptance Criteria:**
- [ ] Validasi kuota mencegah overbooking
- [ ] Permintaan tersimpan dengan status PENDING
- [ ] Kode booking unik digenerate"

gh issue create --title "[BE-05] API Panel Admin: Verifikasi & Tindakan Reservasi" \
  --label "backend,priority:high" \
  --body "### Domain: Admin Management
**User Story:**
Sebagai pengelola desa wisata, saya membutuhkan endpoint untuk melihat semua reservasi masuk serta mengubah status (Konfirmasi / Tolak).

**Spesifikasi Endpoint:**
- \`GET /api/v1/admin/reservations\` (Filter status: PENDING, CONFIRMED, REJECTED)
- \`PATCH /api/v1/admin/reservations/:id/status\`
  \`\`\`json
  {
    \"status\": \"CONFIRMED\", // atau \"REJECTED\"
    \"rejection_reason\": \"Kapasitas penuh karena cuaca buruk\"
  }
  \`\`\`

**Acceptance Criteria:**
- [ ] Pengelola dapat memverifikasi reservasi secara manual
- [ ] Pengurangan kuota efektif saat status menjadi CONFIRMED
- [ ] History status tercatat"

echo "🎨 Membuat Tiket Frontend (FE)..."

gh issue create --title "[FE-01] Setup Project, Tailwind Design System & Layout Utama" \
  --label "frontend,priority:high" \
  --body "### Domain: Global Layout & Theme
**User Story:**
Sebagai developer, saya membutuhkan arsitektur frontend dengan styling yang telah disesuaikan dengan desain Figma desa wisata.

**Tugas:**
- Setup Navbar dengan logo, menu Wisatawan (Destinasi, UMKM, Reservasi) dan tombol Akses Pengelola
- Setup Footer dengan kontak pengelola desa, sosial media, dan copyright
- Konfigurasi warna identitas desa (Earth tone / Nature green & warm)

**Acceptance Criteria:**
- [ ] Responsive navigation bar (hamburger menu pada mobile)
- [ ] Layout konsisten di semua halaman
- [ ] Zero build warning"

gh issue create --title "[FE-02] Halaman Katalog Destinasi Wisata & Filter Pencarian" \
  --label "frontend,priority:high" \
  --body "### Domain: Wisatawan - Katalog
**User Story:**
Sebagai wisatawan, saya ingin mencari dan memfilter destinasi wisata berdasarkan kategori, rating, dan budget.

**Komponen:**
- \`SearchBar\` (Input teks pencarian nama desa / atraksi)
- \`FilterBar\` (Kategori: Wisata Alam, Budaya, Edukasi, Kuliner)
- \`DestinationCard\` (Gambar, nama, lokasi singkat, harga mulai, rating bintang)
- \`DestinationGrid\` (Tampilan grid responsif 1-col mobile, 3-col desktop)

**Acceptance Criteria:**
- [ ] Filter bekerja secara reaktif atau melalui tombol terapkan
- [ ] Empty state muncul jika pencarian tidak ditemukan
- [ ] Integrasi ke API GET /api/v1/destinations"

gh issue create --title "[FE-03] Halaman Detail Destinasi, Fasilitas & Daftar Paket Wisata" \
  --label "frontend,priority:high" \
  --body "### Domain: Wisatawan - Detail
**User Story:**
Sebagai wisatawan, saya ingin melihat rincian atraksi, fasilitas yang tersedia, galeri foto, dan opsi paket wisata desa.

**Komponen:**
- \`PhotoGallery\` (Hero banner & thumbnail slider)
- \`FacilityList\` (Badge fasilitas: Parkir, Toilet, Musholla, Homestay)
- \`PackageCard\` (Daftar paket wisata lengkap dengan harga dan tombol Reservasi)
- \`ReviewSection\` (List ulasan pengunjung sebelumnya)

**Acceptance Criteria:**
- [ ] Tampilan rapi dan informatif di perangkat mobile & desktop
- [ ] Tombol 'Pesan Paket' mengarahkan ke form reservasi dengan ID paket terpilih"

gh issue create --title "[FE-04] Halaman Profil UMKM & Showroom Produk Lokal" \
  --label "frontend,priority:medium" \
  --body "### Domain: Wisatawan & UMKM
**User Story:**
Sebagai wisatawan, saya ingin menjelajahi produk kerajinan tangan dan makanan khas yang dijual oleh warga lokal desa.

**Komponen:**
- \`MSMEHeader\` (Profil usaha warga, alamat, jam operasional)
- \`ProductCard\` (Foto produk, nama, harga, tombol Hubungi Penjual / Chat WhatsApp)
- \`ProductGrid\` (Grid responsif katalog produk)

**Acceptance Criteria:**
- [ ] Tautan WhatsApp otomatis terisi pesan pemesanan produk
- [ ] Desain selaras dengan Figma"

gh issue create --title "[FE-05] Formulir Permintaan Reservasi & Validasi Kapasitas" \
  --label "frontend,priority:high" \
  --body "### Domain: Wisatawan - Reservasi
**User Story:**
Sebagai wisatawan, saya ingin mengisi data pemesanan reservasi secara interaktif dan melihat status kuota secara transparan.

**Komponen:**
- \`DatePicker\` (Pemilihan tanggal kunjungan dengan penanda tanggal penuh)
- \`CounterInput\` (Jumlah orang dewasa & anak-anak)
- \`PriceSummary\` (Kalkulasi total biaya paket)
- \`ReservationSuccessModal\` (Menampilkan nomor tiket reservasi dan instruksi konfirmasi pengelola)

**Acceptance Criteria:**
- [ ] Validasi form (nama, email, no HP tidak boleh kosong)
- [ ] Mencegah submit jika kapasitas tanggal penuh
- [ ] Integrasi ke API POST /api/v1/reservations"

gh issue create --title "[FE-06] Panel Pengelola: Dashboard & Manajemen Status Reservasi" \
  --label "frontend,priority:high" \
  --body "### Domain: Pengelola - Admin Panel
**User Story:**
Sebagai pengelola desa, saya ingin melihat daftar reservasi yang masuk, memverifikasi ketersediaan, dan mengonfirmasi atau menolak permintaan.

**Komponen:**
- \`StatCard\` (Total reservasi pending, terkonfirmasi, pengunjung hari ini)
- \`ReservationTable\` (Daftar reservasi dengan filter status)
- \`ActionModal\` (Modal konfirmasi & input alasan jika ditolak)

**Acceptance Criteria:**
- [ ] Pengelola dapat memfilter status PENDING, CONFIRMED, REJECTED
- [ ] Aksi konfirmasi/tolak langsung memperbarui data di tabel
- [ ] Integrasi ke API PATCH /api/v1/admin/reservations/:id/status"

gh issue create --title "[FE-07] Panel Pengelola: Form CRUD Destinasi & Pengaturan Kuota" \
  --label "frontend,priority:medium" \
  --body "### Domain: Pengelola - Konten
**User Story:**
Sebagai pengelola desa, saya ingin menambahkan atraksi wisata baru dan mengatur kapasitas pengunjung per hari.

**Komponen:**
- \`DestinationForm\` (Input nama, deskripsi, upload gambar, harga paket)
- \`QuotaSettingTable\` (Pengaturan kuota maksimal harian)

**Acceptance Criteria:**
- [ ] Form memiliki validasi input yang lengkap
- [ ] Perubahan kuota harian langsung tersimpan ke backend"

echo "🎉 Semua Label dan 12 Tiket (BE & FE) berhasil dibuat di GitHub!"
