import 'dart:io';

import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ImageService {
  final LoggerService _loggerService = locator<LoggerService>();
  final _supabase = Supabase.instance.client;

  Future<String> uploadImage(File imageFile) async {
    final fileExt = imageFile.path.split('.').last;
    final fileName = const Uuid().v4(); // e.g., random UUID
    final filePath = 'receipts/$fileName.$fileExt';

    _loggerService.info('Uploading image to storage: $filePath');

    try {
      final bytes = await imageFile.readAsBytes();

      // Upload image to Supabase storage
      final response = await _supabase.storage
          .from('receipts') // Bucket name
          .uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(contentType: 'image/$fileExt'),
          );

      if (response.startsWith('receipts/')) {
        // Generate public URL (assuming bucket is public)
        final publicUrl = _supabase.storage
            .from('receipts')
            .getPublicUrl(filePath);

        _loggerService.info('Image uploaded successfully: $publicUrl');
        return publicUrl;
      } else {
        throw Exception('Unexpected response: $response');
      }
    } catch (e, stackTrace) {
      _loggerService.error(
        'Error uploading image: $filePath',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow; // Re-throw the exception to be handled by the caller
    }
  }
}
