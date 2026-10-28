import 'dart:io';

import 'package:flutter/services.dart';

import '../data/backup.dart';

/// Actions système déclenchées par l'utilisateur, sans réseau (SPEC §1) :
/// partage de texte, sélecteur de fichiers, galerie, appareil photo, écran
/// maintenu allumé. Implémentées dans `MainActivity.kt`.
abstract class PlatformBridge {
  Future<void> shareText(String text, String subject);
  Future<void> keepScreenOn(bool on);
  Future<bool> saveDocument(String fileName, String mimeType, Uint8List bytes);
  Future<Uint8List?> openDocument();

  /// Copie le fichier choisi par l'utilisateur vers [destPath], en flux.
  Future<bool> copyDocument(String destPath);
  Future<bool> pickImage({required bool camera, required String destPath});
}

class ChannelPlatformBridge implements PlatformBridge {
  static const _channel = MethodChannel('popote/platform');

  @override
  Future<void> shareText(String text, String subject) =>
      _channel.invokeMethod('shareText', {'text': text, 'subject': subject});

  @override
  Future<void> keepScreenOn(bool on) =>
      _channel.invokeMethod('keepScreenOn', {'on': on});

  @override
  Future<bool> saveDocument(
    String fileName,
    String mimeType,
    Uint8List bytes,
  ) async =>
      await _channel.invokeMethod<bool>('saveDocument', {
        'fileName': fileName,
        'mimeType': mimeType,
        'bytes': bytes,
      }) ??
      false;

  @override
  Future<Uint8List?> openDocument() =>
      _channel.invokeMethod<Uint8List>('openDocument');

  @override
  Future<bool> copyDocument(String destPath) async =>
      await _channel.invokeMethod<bool>('copyDocument', {'dest': destPath}) ??
      false;

  @override
  Future<bool> pickImage({
    required bool camera,
    required String destPath,
  }) async =>
      await _channel.invokeMethod<bool>('pickImage', {
        'source': camera ? 'camera' : 'gallery',
        'dest': destPath,
      }) ??
      false;
}

/// Photos des recettes perso, dans le dossier privé de l'app.
class FilePhotoStore implements PhotoStore {
  FilePhotoStore(this.dir);

  final Directory dir;

  File file(String name) => File('${dir.path}/$name');

  @override
  Future<Uint8List?> read(String name) async {
    final f = file(name);
    return f.existsSync() ? f.readAsBytes() : null;
  }

  @override
  Future<void> write(String name, Uint8List bytes) async {
    await dir.create(recursive: true);
    await file(name).writeAsBytes(bytes);
  }
}
