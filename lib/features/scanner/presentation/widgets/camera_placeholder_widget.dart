import 'package:flutter/material.dart';
import 'package:rupiahvoice/core/constants/app_colors.dart';
import 'package:rupiahvoice/core/constants/app_strings.dart';

/// Widget placeholder area kamera sebelum integrasi modul kamera fisik pada Milestone 4
class CameraPlaceholderWidget extends StatelessWidget {
  const CameraPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${AppStrings.cameraPlaceholderTitle}. ${AppStrings.cameraPlaceholderHint}',
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            // ignore: deprecated_member_use
            color: AppColors.primaryAmber.withOpacity(0.4),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: 64,
              // ignore: deprecated_member_use
              color: AppColors.primaryAmber.withOpacity(0.8),
            ),
            const SizedBox(height: 12),
            const Text(
              AppStrings.cameraPlaceholderTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.darkTextPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                AppStrings.cameraPlaceholderHint,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.darkTextSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
