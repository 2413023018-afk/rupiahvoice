/// Kumpulan konstanta teks dan pesan ramah aksesibilitas dalam Bahasa Indonesia.
class AppStrings {
  // Identitas & Sapaan
  static const String appName = 'RUPIAHVOICE';
  static const String appSubtitle = 'Pengenal Uang Kertas Rupiah Aksesibel';
  static const String welcomeGreeting =
      'RUPIAHVOICE siap. Goyangkan ponsel atau ketuk tombol untuk memindai.';

  // Instruksi & Panduan
  static const String shakeInstruction =
      'Goyangkan ponsel atau tekan tombol SCAN UANG untuk memindai.';

  // Tombol & Aksi
  static const String scanButtonLabel = 'SCAN UANG';
  static const String scanButtonSemanticsHint =
      'Ketuk tombol besar ini atau goyangkan ponsel untuk memindai uang kertas rupiah';
  static const String rescanButtonLabel = 'PINDAI ULANG';
  static const String rescanButtonSemanticsHint =
      'Ketuk tombol ini untuk memindai kembali atau mengulang pembacaan';

  // Indikator Status Aplikasi
  static const String statusReady = 'Siap Memindai';
  static const String statusProcessing = 'Sedang memproses...';
  
  // Area Hasil Pindai
  static const String resultTitle = 'Hasil Pemindaian';
  static const String initialResultPlaceholder = 'Belum ada pemindaian';
  static const String confidenceLabel = 'Tingkat Keyakinan:';
  
  // Placeholder Kamera
  static const String cameraPlaceholderTitle = 'Tinjauan Kamera';
  static const String cameraPlaceholderHint =
      'Area pratinjau kamera akan aktif pada Milestone 4';

  // Penanganan Error Ramah Aksesibilitas
  static const String errorUnrecognized =
      'Nominal belum terbaca jelas. Silakan ratakan uang dan coba lagi.';
  static const String errorTooDark =
      'Pencahayaan terlalu gelap. Silakan nyalakan lampu atau gunakan senter.';
}
