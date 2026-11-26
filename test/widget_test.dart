import 'package:flutter_test/flutter_test.dart';
import 'package:rupiahvoice/main.dart';
import 'package:rupiahvoice/core/constants/app_strings.dart';

void main() {
  testWidgets('Verifikasi seluruh komponen UI Milestone 2 ditampilkan', (WidgetTester tester) async {
    // Bangun aplikasi
    await tester.pumpWidget(const RupiahVoiceApp());

    // 1. Nama RUPIAHVOICE dan subjudul
    expect(find.text(AppStrings.appName), findsOneWidget);
    expect(find.text(AppStrings.appSubtitle), findsOneWidget);

    // 2. Placeholder kamera
    expect(find.text(AppStrings.cameraPlaceholderTitle), findsOneWidget);

    // 3. Area hasil scan & status
    expect(find.text(AppStrings.initialResultPlaceholder), findsOneWidget);
    expect(find.text(AppStrings.statusReady), findsOneWidget);

    // 4. Instruksi Shake to Scan
    expect(find.text(AppStrings.shakeInstruction), findsOneWidget);

    // 5. Tombol besar SCAN UANG
    expect(find.text(AppStrings.scanButtonLabel), findsOneWidget);

    // 6. Tombol scan ulang
    expect(find.text(AppStrings.rescanButtonLabel), findsOneWidget);

    // Uji interaksi tombol SCAN UANG
    await tester.tap(find.text(AppStrings.scanButtonLabel));
    await tester.pump(); // memproses frame awal perubahan status

    // Status berubah menjadi sedang memproses
    expect(find.text(AppStrings.statusProcessing), findsOneWidget);

    // Tunggu simulasi selesai
    await tester.pumpAndSettle();

    // Verifikasi hasil scan terbarui
    expect(find.text('Rp 50.000 (Simulasi UI)'), findsOneWidget);

    // Uji interaksi tombol PINDAI ULANG
    await tester.tap(find.text(AppStrings.rescanButtonLabel));
    await tester.pumpAndSettle();

    // Hasil kembali ke placeholder awal
    expect(find.text(AppStrings.initialResultPlaceholder), findsOneWidget);
  });
}
