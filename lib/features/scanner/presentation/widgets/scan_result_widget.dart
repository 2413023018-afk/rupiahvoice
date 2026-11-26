import 'package:flutter/material.dart';
import 'package:rupiahvoice/core/constants/app_colors.dart';

/// Area penampil hasil pemindaian nominal dengan kontras tinggi untuk low vision
class ScanResultWidget extends StatelessWidget {
  final String currentResult;
  final String statusText;
  final bool isScanning;

  const ScanResultWidget({
    super.key,
    required this.currentResult,
    required this.statusText,
    required this.isScanning,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      liveRegion: true,
      label: 'Status: $statusText. Hasil: $currentResult',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.accentCyan,
            width: 2.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Status baris atas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isScanning ? AppColors.statusWarning : AppColors.statusSuccess,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  statusText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentCyan,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Nominal hasil deteksi teks besar
            Text(
              currentResult,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColors.darkTextPrimary,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
