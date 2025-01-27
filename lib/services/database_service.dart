import 'dart:io';

import 'package:kaze_app/models/app_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  // appUser Table
  final _supabase = Supabase.instance.client;
  final appUserTable = Supabase.instance.client.from('appusers');

  Future createAppUser(AppUser newAppUser) async {
    await appUserTable.insert(newAppUser.toJson());
  }

  Future? getUserByUsername(String username) async {
    final response =
        await appUserTable.select().eq('username', username).maybeSingle();

    if (response == null) return null;

    return AppUser.fromJson(response);
  }

  Future<String> uploadImage(File imageFile) async {
    final fileExt = imageFile.path.split('.').last;
    final fileName = const Uuid().v4(); // e.g. random UUID
    final filePath = 'receipts/$fileName.$fileExt';

    final bytes = await imageFile.readAsBytes();

    // v2.8.3: Use the Supabase storage upload
    final response = await _supabase.storage
        .from('receipts') // bucket name
        .uploadBinary(
          filePath,
          bytes,
          fileOptions: FileOptions(
            contentType: 'image/$fileExt',
          ),
        );

    // Check for errors or success
    // The `uploadBinary()` returns a String? containing the file path if successful, or an error if there's a failure.
    if (response.startsWith('receipts/')) {
      // Generate public URL (if your bucket is public) or create signed URL (if private)
      final publicUrl =
          _supabase.storage.from('receipts').getPublicUrl(filePath);
      return publicUrl;
    } else {
      throw Exception('Error uploading image: $response');
    }
  }
}
