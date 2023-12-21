import 'package:flutter/material.dart';
import 'package:warmindo_pos/services/shared_preferences.dart';

import '../crypt.dart';
import '../main.dart';
import '../model/pengguna.dart';
import '../ui/pages/main_page.dart';
import '../ui/widgets/toast.dart';

Future<void> authenticateUser(
    BuildContext context, String username, String password) async {
  try {
    final response = await supabase
        .from('pengguna')
        .select('idpengguna, username, password')
        .eq('username', username)
        .single();

    if (response != null) {
      final user = response;
      String storedPassword = user['password'].toString();
      storedPassword = decryptMyData(storedPassword);

      if (storedPassword == password) {
        String id = user['idpengguna'] ?? '1';
        String name = user['username'];
        String urlImage = user['foto'] ?? 'default_image_url';

        final pengguna = Pengguna(
            id: id,
            username: name,
            createdAt: DateTime.now(),
            profileImageUrl: urlImage);

        UserPreferences.saveUser(pengguna);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      } else {
        showToast(context, "Username atau Password yang anda masukkan salah");
      }
    } else {
      showToast(context, "Username atau Password yang anda masukkan salah");
    }
  } catch (e) {
    showToast(context, e.toString());
  }
}
