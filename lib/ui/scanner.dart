import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'strings.dart';

/// Lecteur de codes-barres, simulable dans les tests (SPEC-V2 §12).
abstract class BarcodeScannerService {
  /// Aperçu caméra qui appelle [onCode] à chaque code lu.
  Widget preview(void Function(String code) onCode);
}

/// Lecture entièrement sur l'appareil : `mobile_scanner` en version
/// « bundled » (modèle ML Kit embarqué dans l'APK, jamais téléchargé).
class CameraBarcodeScanner implements BarcodeScannerService {
  const CameraBarcodeScanner();

  @override
  Widget preview(void Function(String code) onCode) =>
      _CameraPreview(onCode: onCode);
}

class _CameraPreview extends StatefulWidget {
  const _CameraPreview({required this.onCode});
  final void Function(String code) onCode;

  @override
  State<_CameraPreview> createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<_CameraPreview> {
  final _controller = MobileScannerController(
    formats: const [
      BarcodeFormat.ean13,
      BarcodeFormat.ean8,
      BarcodeFormat.upcA,
      BarcodeFormat.upcE,
    ],
  );
  String? _last;
  DateTime _lastAt = DateTime(2000);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: MobileScanner(
      controller: _controller,
      onDetect: (capture) {
        final code = capture.barcodes
            .map((b) => b.rawValue)
            .whereType<String>()
            .firstOrNull;
        if (code == null) return;
        // Évite de compter dix fois le même paquet tenu devant la caméra.
        final now = DateTime.now();
        if (code == _last && now.difference(_lastAt).inSeconds < 3) return;
        _last = code;
        _lastAt = now;
        widget.onCode(code);
      },
      errorBuilder: (context, error) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(S.scanCameraError, textAlign: TextAlign.center),
        ),
      ),
    ),
  );
}

/// Ouvre un écran de scan pour un seul code ; renvoie le code lu.
Future<String?> scanOnce(BuildContext context, BarcodeScannerService scanner) =>
    Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          appBar: AppBar(title: const Text(S.scanTitle)),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: scanner.preview((code) => Navigator.of(ctx).pop(code)),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () async {
                    final code = await _typeBarcode(ctx);
                    if (code != null && ctx.mounted) {
                      Navigator.of(ctx).pop(code);
                    }
                  },
                  icon: const Icon(Icons.keyboard_rounded),
                  label: const Text(S.scanType),
                ),
              ],
            ),
          ),
        ),
      ),
    );

/// Saisie manuelle du code (étiquette abîmée, caméra refusée).
Future<String?> _typeBarcode(BuildContext context) {
  final c = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text(S.scanType),
      content: TextField(
        controller: c,
        autofocus: true,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: S.barcode),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text(S.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(ctx, c.text.trim()),
          child: const Text(S.ok),
        ),
      ],
    ),
  );
}

Future<String?> typeBarcode(BuildContext context) => _typeBarcode(context);
