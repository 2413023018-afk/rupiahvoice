import 'package:flutter/material.dart';

/// Palet warna aksesibilitas berstandar kontras tinggi (WCAG AAA)
/// Dirancang untuk kenyamanan pengguna low vision dan tunanetra.
class AppColors {
  // Warna Utama (Kontras Tinggi)
  static const Color primaryAmber = Color(0xFFFFD600); // Kuning tajam mudah terlihat di latar gelap
  static const Color primaryOnAmber = Color(0xFF000000); // Teks hitam pekat di atas kuning
  
  static const Color accentCyan = Color(0xFF00E5FF); // Biru terang untuk indikator/highlight
  static const Color accentOnCyan = Color(0xFF000000);

  // Latar Belakang (Deep Dark Mode untuk menghemat daya & mengurangi silau)
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFE0E0E0);

  // Status & Umpan Balik
  static const Color statusSuccess = Color(0xFF00E676); // Hijau terang
  static const Color statusWarning = Color(0xFFFF9100); // Oranye terang
  static const Color statusError = Color(0xFFFF1744);   // Merah terang
  static const Color onStatus = Color(0xFF000000);
}
