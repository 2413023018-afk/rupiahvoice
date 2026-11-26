import 'package:flutter/material.dart';
import 'package:rupiahvoice/core/constants/app_strings.dart';
import 'package:rupiahvoice/core/theme/app_theme.dart';
import 'package:rupiahvoice/features/scanner/presentation/screens/scanner_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RupiahVoiceApp());
}

/// Root widget aplikasi RUPIAHVOICE
class RupiahVoiceApp extends StatelessWidget {
  const RupiahVoiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const ScannerScreen(),
    );
  }
}
