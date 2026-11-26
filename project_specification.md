# Dokumen Spesifikasi Proyek (Project Specification)
## RUPIAHVOICE — Asisten Pengenal Uang Kertas Rupiah Aksesibel

---

## 1. Identitas Aplikasi
* **Nama Aplikasi:** RUPIAHVOICE
* **Tipe Aplikasi:** Mobile Application (Android)
* **Kategori:** Aksesibilitas, Alat Bantu Penglihatan (*Assistive Technology*), Computer Vision
* **Teknologi Utama:** 
  * Framework: Flutter & Dart
  * Desain Sistem: Material 3 (High Contrast & Large Tap Targets)
  * AI & CV: TensorFlow Lite (On-Device Inference)
  * Suara: Text-to-Speech (TTS) Bahasa Indonesia
  * Backend Data Pendukung: Supabase
  * Repositori & Otomasi: GitHub & GitHub Actions (CI/CD)

---

## 2. Deskripsi Aplikasi
RUPIAHVOICE adalah aplikasi aksesibilitas berbasis Android yang dirancang khusus untuk membantu penyandang disabilitas netra (tunanetra total maupun *low vision*) mengenali nilai nominal uang kertas rupiah secara mandiri, cepat, dan aman. 

Aplikasi memanfaatkan kamera ponsel yang dikombinasikan dengan kecerdasan buatan (*computer vision on-device*) untuk mengidentifikasi uang kertas dalam hitungan milidetik tanpa memerlukan koneksi internet, serta mengumumkan nominalnya menggunakan suara Text-to-Speech Bahasa Indonesia dan pola getaran (*haptic feedback*).

---

## 3. Tujuan
1. **Meningkatkan Kemandirian:** Membantu penyandang tunanetra melakukan transaksi tunai mandiri sehari-hari (berbelanja di pasar, membayar transportasi, menerima uang) tanpa ketergantungan pada orang lain.
2. **Mencegah Kesalahan Transaksi:** Mengurangi risiko kekeliruan nominal atau kerugian finansial akibat kesulitan membedakan dimensi fisik uang kertas rupiah.
3. **Aksesibilitas Tanpa Batas:** Menyediakan solusi pengenalan uang yang bekerja 100% luring (*offline*) di perangkat ponsel, hemat daya, dan responsif.

---

## 4. Target Pengguna
1. **Penyandang Tunanetra Total (*Blindness*):** Pengguna yang mengandalkan pendengaran (TTS / TalkBack) dan respon rabaan (*haptic cues*) sepenuhnya.
2. **Penyandang Sisa Penglihatan (*Low Vision*):** Pengguna yang membutuhkan teks berukuran ekstra besar (*large text font*), ikon visual yang mencolok, dan rasio kontras warna tinggi.
3. **Pendamping Disabilitas & Komunitas Inklusi:** Relawan atau keluarga yang memfasilitasi penggunaan ponsel ramah disabilitas bagi penyandang tunanetra.

---

## 5. User Story
* **US-01 (Scan via Goyangan):** Sebagai pengguna tunanetra, saya ingin memindai uang cukup dengan menggoyangkan ponsel (*shake*), agar saya tidak perlu meraba-raba mencari posisi tombol pada layar sentuh.
* **US-02 (Scan via Tombol Manual):** Sebagai pengguna *low vision*, saya ingin memiliki tombol scan berukuran besar dan kontras tinggi di layar sebagai alternatif saat saya sedang tidak bisa menggoyangkan HP.
* **US-03 (Pengumuman Suara):** Sebagai pengguna tunanetra, saya ingin nominal uang langsung dibacakan dalam bahasa Indonesia yang alami dan jelas segera setelah kamera mendeteksi uang.
* **US-04 (Konfirmasi Getaran):** Sebagai pengguna tunanetra di tempat bising (misal: pasar), saya ingin merasakan getaran tertentu ketika proses scan berhasil atau gagal, agar saya tahu status pembacaan uang tanpa harus mendengar suara.
* **US-05 (Dengar Ulang):** Sebagai pengguna, saya ingin dapat mengetuk layar dua kali (*double tap*) untuk mendengarkan kembali nominal uang terakhir yang baru saja dibacakan tanpa harus memposisikan ulang uang kertas.
* **US-06 (Umpan Balik Kondisi Error):** Sebagai pengguna, saya ingin diberi tahu jika uang tidak terbaca atau pencahayaan terlalu gelap, agar saya dapat membetulkan posisi uang kertas.

---

## 6. Acceptance Criteria
* **AC-01:** Aplikasi terbuka langsung dalam Mode Siaga Interaktif dan membacakan sapaan audio pembuka dalam Bahasa Indonesia serta 1 getaran pendek.
* **AC-02:** Pengguna dapat memicu pengambilan gambar menggunakan gestur goyang (*shake*) atau menekan tombol manual.
* **AC-03:** Aplikasi memproses gambar secara *on-device* tanpa mengirim data gambar ke server atau internet.
* **AC-04:** Hasil prediksi nominal hanya dibacakan jika nilai keyakinan (*confidence score*) ≥ batas ambang (*threshold*, default 75%).
* **AC-05:** Jika keyakinan < batas ambang, aplikasi **tidak boleh** menebak nominal secara palsu; aplikasi harus membacakan pesan kegagalan ramah aksesibilitas dan memberikan 1 getaran panjang.
* **AC-06:** Gestur *double-tap* di layar mengulang pembacaan suara nominal terakhir yang berhasil dideteksi.
* **AC-07:** Semua elemen interaktif memiliki anotasi semantik yang kompatibel dengan Android TalkBack.

---

## 7. Alur Pengguna (User Flow)
```text
[Buka Aplikasi]
       │
       ▼
[Mode Siaga Interaktif]
├─ Kamera aktif di latar belakang
├─ 1 Getar Pendek
└─ TTS: "RUPIAHVOICE siap. Goyangkan ponsel atau ketuk layar untuk memindai."
       │
       ├───> [Pemicu: Goyang Ponsel (Shake to Scan)] ───┐
       │                                                │
       └───> [Pemicu: Tekan Tombol Scan Manual] ────────┤
                                                        │
                                                        ▼
                                             [Ambil 1 Frame Gambar]
                                                        │
                                                        ▼
                                            [AI On-Device Inference]
                                                        │
                              ┌─────────────────────────┴────────────────────────┐
                              ▼                                                  ▼
                  [Confidence >= 75%]                                   [Confidence < 75% / Objek Tidak Jelas]
                              │                                                  │
                              ├─ 2 Getaran Pendek                                ├─ 1 Getaran Panjang
                              ├─ TTS: "[Nominal] Rupiah"                         └─ TTS: "Nominal belum terbaca jelas.
                              │                                                          Ratakan uang dan coba lagi."
                              ▼                                                  │
                  [Mode Siaga Pasca-Pindai]                                      │
                              │                                                  │
             ┌────────────────┴────────────────┐                                 │
             ▼                                 ▼                                 │
    [Double Tap Layar]             [Goyang HP / Tombol Scan]                     │
             │                                 │                                 │
   TTS: Ulangi nominal              Pindai uang lembar baru                      │
             │                                 │                                 │
             └─────────────────────────────────┴─────────────────────────────────┘
```

---

## 8. Struktur Layar (Single Screen Architecture)
Aplikasi hanya memiliki **1 layar utama (Single Screen)** tanpa navigasi halaman bertingkat, laci navigasi (*drawer*), atau *bottom navigation bar*, guna memastikan pengguna tunanetra tidak tersesat di dalam aplikasi:

* **Lapisan 1 (Background):** *Camera Preview Viewfinder* memenuhi seluruh dimensi layar ponsel.
* **Lapisan 2 (Top Status Overlay):**
  * Teks Status Berukuran Besar (untuk *low vision*): Menampilkan teks seperti *"Siap Memindai"*, *"Memproses..."*, *"Rp 50.000"*.
  * Tombol Senter/Flash: Berada di pojok atas dengan ukuran sentuh minimal 48x48 dp.
* **Lapisan 3 (Bottom Action Overlay):**
  * Tombol Scan Manual Raksasa: Menempati sepertiga bagian bawah layar dengan label *"KETUK UNTUK MEMINDAI"*, sudut membulat, dan warna berdaya kontras tinggi.

---

## 9. UI dan Aksesibilitas
* **Prinsip Desain:** Material 3 dengan fokus utama pada pemenuhan kriteria WCAG 2.1 Level AAA.
* **Rasio Kontras:** Minimal 7:1 untuk teks terhadap latar belakang, memastikan keterbacaan optimal bagi pengguna *low vision*.
* **Semantik TalkBack:**
  * Seluruh tombol dibungkus dengan widget `Semantics` yang memiliki deskripsi jelas (`label`, `hint`, dan `button: true`).
  * Menggunakan `SemanticsService.announce()` untuk mengabarkan perubahan status secara otomatis ke pembaca layar sistem.
* **Haptic Feedback:**
  * Haptic Ticks ringan saat memicu scan.
  * Haptic Success (getar ganda) saat pengenalan berhasil.
  * Haptic Warning (getar panjang tunggal) saat gagal deteksi.

---

## 10. Ruang Lingkup (Scope)
* Pemindaian satu lembar uang kertas rupiah dalam satu waktu (*Single Banknote Scanner*).
* Dukungan emisi uang kertas rupiah yang beredar (seri 2022 dan seri sebelumnya yang sah): Rp 1.000, Rp 2.000, Rp 5.000, Rp 10.000, Rp 20.000, Rp 50.000, Rp 100.000.
* Pemrosesan citra dan klasifikasi AI secara lokal di perangkat (*On-Device Machine Learning*).
* Pengumuman hasil pengenalan via Text-to-Speech Bahasa Indonesia.
* Sensor getar guncangan (*Shake to Scan*) dan tombol manual berukuran besar.
* Integrasi Supabase untuk pembacaan konfigurasi dasar aplikasi (*remote config*).
* Otomasi build file instalasi Android (APK) melalui GitHub Actions.

---

## 11. Batasan (Non-Scope & Out of Boundary)
Sesuai batasan ketat dokumen PRD:
1. **Tidak Memeriksa Keaslian Uang:** Aplikasi bukan alat pendeteksi uang palsu (*counterfeit detector*).
2. **Tidak Menghitung Beberapa Lembar:** Tidak memproses tumpukan atau jejeran beberapa lembar uang sekaligus.
3. **Tidak Menghitung Total Uang:** Tidak memiliki kalkulator akumulasi saldo atau total nominal.
4. **Tidak Menghitung Uang Kembalian:** Tidak ada kalkulasi transaksi belanja atau sisa kembalian.
5. **Bukan Pengelola Keuangan:** Tidak memuat modul pencatatan dompet, budgeting, atau riwayat transaksi keuangan.
6. **Bukan Pengenal Objek Umum:** Model AI dikhususkan untuk uang kertas rupiah, bukan objek sembarang.
7. **Privasi Gambar:** Tidak menyimpan foto uang ke penyimpanan lokal permanen ponsel secara default.
8. **Tidak Mengirim Gambar ke Supabase:** Tidak ada lalu lintas unggah gambar uang ke backend internet.
9. **Tanpa Prediksi Palsu:** Tidak menghasilkan tebakan nominal buatan jika model AI belum mendeteksi pola dengan keyakinan yang cukup.

---

## 12. Arsitektur Flutter
Aplikasi menggunakan pola **Feature-First Clean Architecture** yang ramah pemula, modular, dan memisahkan logika dari tampilan:

```text
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart        # Palet warna Material 3 kontras tinggi
│   │   ├── app_strings.dart       # Pesan lokal bahasa Indonesia
│   │   └── app_thresholds.dart    # Nilai default keyakinan AI
│   ├── services/
│   │   ├── tts_service.dart       # Pengendali Text-to-Speech
│   │   └── haptic_service.dart    # Pengendali vibrasi/haptic cues
│   └── theme/
│       └── app_theme.dart         # Konfigurasi tema aksesibel
├── features/
│   ├── camera/
│   │   ├── controllers/
│   │   │   └── camera_controller.dart
│   │   └── services/
│   │       └── shake_detector_service.dart # Sensor akselerometer
│   ├── classifier/
│   │   ├── models/
│   │   │   └── recognition_result.dart     # Entitas nominal & confidence
│   │   └── services/
│   │       ├── tflite_classifier.dart      # Inference engine TFLite
│   │       └── image_preprocessor.dart     # Penyesuaian ukuran & normalisasi
│   ├── config/
│   │   └── services/
│   │       └── supabase_config_service.dart# Pengambil remote config
│   └── scanner/
│       ├── presentation/
│       │   ├── screens/
│       │   │   └── scanner_screen.dart     # Single screen utama
│       │   └── widgets/
│       │       ├── accessible_scan_button.dart
│       │       ├── camera_view_widget.dart
│       │       └── status_overlay_widget.dart
└── main.dart                               # Entry point aplikasi
```

---

## 13. Rencana Kamera
* Menggunakan plugin resmi Flutter `camera` yang memanfaatkan antarmuka modern Android CameraX.
* **Resolusi:** Cukup menggunakan resolusi menengah (*medium / 720p*) untuk menghemat daya baterai, mengurangi panas ponsel, dan mempercepat *capture frame*.
* **Manajemen Izin:** Menggunakan `permission_handler` untuk memeriksa izin kamera dengan dialog dan pengumuman suara yang jelas jika izin ditolak.
* **Kontrol Lampu Kilat (*Flash Torch*):** Fitur senter dapat dihidupkan manual atau otomatis saat kondisi cahaya lingkungan terdeteksi minim.

---

## 14. Rencana Model AI
* **Format Model:** TensorFlow Lite (`.tflite`) yang dikuantisasi (*int8* atau *float16*) untuk ukuran berkas kecil (< 10 MB) dan eksekusi cepat.
* **Arsitektur Dasar:** MobileNetV2 atau EfficientNet-Lite yang dilatih khusus (*transfer learning*) pada dataset uang kertas rupiah.
* **Daftar Label Keluaran (`labels.txt`):**
  * `1000` (Seribu Rupiah)
  * `2000` (Dua Ribu Rupiah)
  * `5000` (Lima Ribu Rupiah)
  * `10000` (Sepuluh Ribu Rupiah)
  * `20000` (Dua Puluh Ribu Rupiah)
  * `50000` (Lima Puluh Ribu Rupiah)
  * `100000` (Seratus Ribu Rupiah)
  * `unknown` (Objek tidak dikenali / bukan uang)
* **Pustaka Integrasi:** `tflite_flutter` untuk menjalankan inferensi lokal langsung di CPU/NNAPI Android.

---

## 15. Rencana Preprocessing
* **Input Resolusi Model:** Citra masukan dinormalisasi ke dimensi baku model (misal: `224x224` piksel atau `300x300` piksel, format RGB).
* **Normalisasi Piksel:** Nilai piksel `[0, 255]` dikonversi sesuai parameter model (misal: dinormalisasi ke `[0.0, 1.0]` atau `[-1.0, 1.0]`).
* **Format Pengambilan Gambar:** *Frame* foto ditangkap dalam memori (*in-memory bytes buffer*) tanpa perlu ditulis permanen ke media penyimpanan fisik, menjaga performa dan mematuhi batasan privasi PRD.

---

## 16. Rencana Confidence Threshold
* **Nilai Ambang Batas Default:** **0.75 (75%)**.
* **Mekanisme Validasi:**
  * Jika `top_prediction.confidence >= 0.75` dan `label != 'unknown'`: Prediksi valid -> Bunyikan nominal.
  * Jika `top_prediction.confidence < 0.75` atau `label == 'unknown'`: Prediksi diabaikan -> Bunyikan pesan peringatan uang belum terbaca jelas.
* **Fleksibilitas:** Nilai ambang batas dapat ditarik secara dinamis dari tabel `app_config` Supabase saat aplikasi terhubung ke internet, dengan nilai fallback statis `0.75` jika luring.

---

## 17. Rencana Text-to-Speech (TTS)
* **Pustaka:** `flutter_tts`.
* **Bahasa & Vokal:**
  * Bahasa: `id-ID` (Bahasa Indonesia).
  * Kecepatan Bicara (*Speech Rate*): `0.5` (kecepatan wajar, tidak terlalu cepat, mudah dipahami).
  * Nada Bicara (*Pitch*): `1.0` (suara natural).
* **Manajemen Antrean Suara:** Mematikan (*stop*) audio yang sedang berjalan sebelum membacakan hasil baru agar suara tidak bertumpuk atau bergema.
* **Integrasi Dengar Ulang:** Menyimpan string nominal terakhir dalam memori untuk dieksekusi ulang saat mendeteksi gestur *double-tap*.

---

## 18. Rencana Shake to Scan
* **Pustaka:** `sensors_plus` untuk membaca data sensor akselerometer ponsel.
* **Algoritma Guncangan:** Menghitung besar akselerasi total $g = \sqrt{x^2 + y^2 + z^2}$. Jika melebihi ambang batas guncangan (misal: 12–15 m/s²) selama durasi singkat, aksi pindai dipicu.
* **Debouncing & Cooldown:** Memberikan jeda waktu (*cooldown interval*) minimal 2 detik setelah guncangan terdeteksi agar tidak terjadi pemindaian ganda yang tidak disengaja.

---

## 19. Rencana Supabase
* **Kebutuhan Minimal:** Menjalankan prinsip data pendukung ringan tanpa menyentuh privasi pengguna.
* **Zero-Authentication:** Aplikasi dapat dioperasikan secara penuh tanpa registrasi atau login akun (*no sign-up barrier*).
* **Pustaka:** `supabase_flutter`.

---

## 20. Rencana Database
Supabase PostgreSQL digunakan untuk mengelola 2 tabel sederhana:

### 1. Tabel `app_config`
Menyimpan parameter konfigurasi global aplikasi.
* `id` (uuid, primary key)
* `key` (text, unique, e.g., `'confidence_threshold'`, `'help_center_phone'`)
* `value` (jsonb/text, e.g., `'0.75'`)
* `updated_at` (timestamp)

### 2. Tabel `model_metadata`
Menyimpan informasi versi model AI yang sedang didukung.
* `id` (uuid, primary key)
* `version_name` (text, e.g., `'v1.0.0-seri2022'`)
* `supported_denominations` (text[], e.g., `['1000','2000','5000','10000','20000','50000','100000']`)
* `release_notes` (text)
* `created_at` (timestamp)

---

## 21. Rencana Row Level Security (RLS)
* **Keamanan Default:** RLS diaktifkan (`ENABLE ROW LEVEL SECURITY`) pada seluruh tabel.
* **Kebijakan Akses (Policy):**
  * `app_config`: Kebijakan `SELECT` diizinkan untuk peran `anon` (publik hanya bisa membaca). Operasi `INSERT`, `UPDATE`, `DELETE` hanya untuk akun pengembang / service role.
  * `model_metadata`: Kebijakan `SELECT` diizinkan untuk peran `anon`.
* Tidak ada tabel yang mengizinkan penulisan publik tanpa otentikasi.

---

## 22. Rencana GitHub
* **Struktur Cabang (*Branching Strategy*):**
  * `main`: Cabang produksi yang stabil dan siap rilis.
  * `development`: Cabang integrasi fitur harian.
  * `feature/*`: Cabang tugas spesifik per fitur (misal: `feature/camera-setup`, `feature/tflite-pipeline`).
* **Pengelolaan Repositori:** Mengabaikan berkas sensitif dan *build artifacts* melalui `.gitignore` bawaan Flutter.

---

## 23. Rencana GitHub Actions (CI/CD)
* **Lokasi Berkas Alur Kerja:** `.github/workflows/build_apk.yml`
* **Pemicu Alur (*Trigger*):** Setiap `push` atau `pull_request` ke cabang `main` atau saat pembuatan `release tag` (misal: `v1.0.0`).
* **Langkah-Langkah Pipeline:**
  1. **Checkout Code:** Mengambil repositori.
  2. **Setup Java:** Memasang Java Development Kit (JDK 17).
  3. **Setup Flutter:** Memasang Flutter SDK versi stabil terbaru.
  4. **Install Dependencies:** Menjalankan `flutter pub get`.
  5. **Analyze & Test:** Menjalankan `flutter analyze` dan `flutter test`.
  6. **Build APK:** Mengeksekusi `flutter build apk --release`.
  7. **Upload Artifacts:** Menyimpan berkas `app-release.apk` agar dapat langsung diunduh dari halaman GitHub Actions dan dipasang ke perangkat Android pengguna.

---

## 24. Rencana Pengujian
1. **Unit Testing:**
   * Pengujian logika ambang batas keyakinan (*threshold validation logic*).
   * Pengujian pemetaan label string nominal ke format pembacaan TTS.
2. **Widget & Semantics Testing:**
   * Memastikan tombol memiliki atribut `Semantics` aktif dan dapat dibaca oleh pembaca layar.
   * Memastikan respon ketuk manual dan *double-tap* bekerja sesuai alur.
3. **Accessibility Testing (Manual):**
   * Mengaktifkan Android TalkBack pada ponsel fisik dan melakukan navigasi dengan layar tertutup.
   * Menguji pemindaian uang dalam berbagai skenario pencahayaan dan variasi sudut.
4. **Sensor Testing:**
   * Menguji sensitivitas sensor *shake* agar tidak reaktif terhadap guncangan ringan saat ponsel ditaruh di dalam saku celana atau tas.

---

## 25. Daftar File yang Harus Disiapkan Pengguna
Sebelum implementasi kode dimulai, pengguna/pengembang perlu menyiapkan:
1. **File Model & Aset AI:**
   * `assets/models/rupiah_classifier.tflite` (Model TFLite pengenal uang).
   * `assets/models/labels.txt` (Daftar label nominal).
2. **Kredensial Supabase:**
   * URL Project Supabase (`SUPABASE_URL`).
   * Anon Public Key Supabase (`SUPABASE_ANON_KEY`).
3. **Perangkat Pengujian Fisik:**
   * 1 unit ponsel Android dengan kamera berfungsi dan sensor getar aktif untuk verifikasi langsung.

---

## 26. Risiko dan Kendala
| No | Risiko / Kendala | Dampak | Strategi Mitigasi |
|:---|:---|:---|:---|
| 1 | Uang kertas rupiah terlalu lecek, terlipat dua, atau sobek | Model gagal mengenali nominal | Mengembalikan pesan ramah untuk meratakan uang, tidak menebak sembarangan |
| 2 | Pencahayaan lingkungan sangat redup | Gambar gelap dan prediksi tidak akurat | Menambahkan deteksi kecerahan rata-rata frame untuk menyalakan senter flash otomatis |
| 3 | Perbedaan suara mesin TTS pada merk ponsel yang berbeda | Kualitas suara ucapan berbeda-beda | Menggunakan bahasa standar `id-ID` dan memastikan integrasi TalkBack sebagai cadangan |
| 4 | Ketidaksengajaan terpicu saat ponsel dibawa berjalan | Kamera mengambil gambar tidak diinginkan | Menerapkan algoritma ambang percepatan guncangan (*shake threshold*) dengan interval jeda (*cooldown*) |
| 5 | Performa inferensi lambat pada ponsel spesifikasi rendah | Pembacaan nominal terasa lambat | Menggunakan kuantisasi model TFLite *int8* yang sangat ringan dan efisien di CPU |

---
*Dokumen ini merupakan spesifikasi resmi pengembangan RUPIAHVOICE yang mengikat ruang lingkup proyek sesuai PRD RUPIAHVOICE.*
