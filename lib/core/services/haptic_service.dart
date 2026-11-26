import 'package:flutter/services.dart';

/// Layanan getaran haptic untuk memberikan umpan balik taktil kepada pengguna tunanetra
class HapticService {
  /// 1 getaran lembut saat pemicu scan aktif atau aplikasi siap
  static Future<void> triggerScanFeedback() async {
    await HapticFeedback.mediumImpact();
  }

  /// 2 kali getaran pendek saat pemindaian berhasil
  static Future<void> successFeedback() async {
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 150));
    await HapticFeedback.lightImpact();
  }

  /// 1 getaran panjang / berat saat terjadi kesalahan atau nominal tidak terbaca jelas
  static Future<void> errorFeedback() async {
    await HapticFeedback.heavyImpact();
  }
}
