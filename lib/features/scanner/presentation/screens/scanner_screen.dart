import 'package:flutter/material.dart';
import 'package:rupiahvoice/core/constants/app_colors.dart';
import 'package:rupiahvoice/core/constants/app_strings.dart';
import 'package:rupiahvoice/core/services/haptic_service.dart';
import 'package:rupiahvoice/features/scanner/presentation/widgets/accessible_scan_button.dart';
import 'package:rupiahvoice/features/scanner/presentation/widgets/camera_placeholder_widget.dart';
import 'package:rupiahvoice/features/scanner/presentation/widgets/scan_result_widget.dart';

/// Layar Utama RUPIAHVOICE (Single Screen Architecture)
/// Mengimplementasikan UI modern Material 3, kontras tinggi, dan ramah aksesibilitas.
class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String _scanResult = AppStrings.initialResultPlaceholder;
  String _statusText = AppStrings.statusReady;
  bool _isScanning = false;

  /// Simulasi tindakan pindai untuk Milestone 2 (haptic feedback & update status visual)
  Future<void> _handleScan() async {
    if (_isScanning) return;

    await HapticService.triggerScanFeedback();

    setState(() {
      _isScanning = true;
      _statusText = AppStrings.statusProcessing;
    });

    // Simulasi delay singkat pengolahan (sebelum modul AI terpasang di Milestone 5)
    await Future.delayed(const Duration(milliseconds: 600));

    await HapticService.successFeedback();

    if (mounted) {
      setState(() {
        _isScanning = false;
        _statusText = AppStrings.statusReady;
        _scanResult = 'Rp 50.000 (Simulasi UI)';
      });
    }
  }

  /// Tindakan pindai ulang
  Future<void> _handleRescan() async {
    await HapticService.triggerScanFeedback();
    setState(() {
      _scanResult = AppStrings.initialResultPlaceholder;
      _statusText = AppStrings.statusReady;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkSurface,
        elevation: 0,
        centerTitle: true,
        title: Semantics(
          header: true,
          child: Column(
            children: [
              Text(
                AppStrings.appName,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: AppColors.primaryAmber,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                AppStrings.appSubtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkTextSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Placeholder Kamera (Area Utama)
              const Expanded(
                flex: 4,
                child: CameraPlaceholderWidget(),
              ),

              const SizedBox(height: 16),

              // 2. Area Hasil Scan & Status
              ScanResultWidget(
                currentResult: _scanResult,
                statusText: _statusText,
                isScanning: _isScanning,
              ),

              const SizedBox(height: 14),

              // 3. Instruksi Shake to Scan
              Semantics(
                label: AppStrings.shakeInstruction,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: AppColors.darkSurface.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.vibration,
                        size: 20,
                        color: AppColors.primaryAmber,
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          AppStrings.shakeInstruction,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkTextSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 4. Tombol Utama Raksasa: SCAN UANG
              AccessibleScanButton(
                label: AppStrings.scanButtonLabel,
                hint: AppStrings.scanButtonSemanticsHint,
                icon: Icons.document_scanner,
                isPrimary: true,
                onPressed: _handleScan,
              ),

              const SizedBox(height: 12),

              // 5. Tombol Sekunder: PINDAI ULANG
              AccessibleScanButton(
                label: AppStrings.rescanButtonLabel,
                hint: AppStrings.rescanButtonSemanticsHint,
                icon: Icons.refresh,
                isPrimary: false,
                onPressed: _handleRescan,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
