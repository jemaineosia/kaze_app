import 'package:kaze_app/models/app_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  // appUser Table
  final appUserTable = Supabase.instance.client.from('appusers');

  Future createAppUser(AppUser newAppUser) async {
    await appUserTable.insert(newAppUser.toMap());
  }

  Future? getUserByUsername(String username) async {
    final response =
        await appUserTable.select().eq('username', username).maybeSingle();

    if (response == null) return null;

    return AppUser.fromMap(response);
  }
}
