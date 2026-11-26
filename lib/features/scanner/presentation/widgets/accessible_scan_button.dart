import 'package:flutter/material.dart';
import 'package:rupiahvoice/core/constants/app_colors.dart';

/// Tombol scan berukuran raksasa dengan kontras tinggi berstandar aksesibilitas (WCAG AAA)
class AccessibleScanButton extends StatelessWidget {
  final String label;
  final String hint;
  final VoidCallback onPressed;
  final bool isPrimary;
  final IconData? icon;

  const AccessibleScanButton({
    super.key,
    required this.label,
    required this.hint,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isPrimary ? AppColors.primaryAmber : AppColors.darkSurface;
    final foregroundColor = isPrimary ? AppColors.primaryOnAmber : AppColors.primaryAmber;
    final borderColor = isPrimary ? Colors.transparent : AppColors.primaryAmber;

    return Semantics(
      button: true,
      label: label,
      hint: hint,
      child: SizedBox(
        width: double.infinity,
        height: isPrimary ? 80.0 : 64.0, // Touch target besar agar mudah disentuh tunanetra
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            elevation: isPrimary ? 6 : 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: borderColor, width: 2.5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: isPrimary ? 34 : 26, color: foregroundColor),
                const SizedBox(width: 12),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: isPrimary ? 24 : 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: foregroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
