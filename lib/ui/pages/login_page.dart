import 'package:flutter/material.dart';
import 'package:warmindo_pos/main.dart';
import 'package:warmindo_pos/ui/shared/gaps.dart';
import 'package:warmindo_pos/ui/shared/theme.dart';
import 'package:warmindo_pos/ui/widgets/button.dart';
import 'package:warmindo_pos/ui/widgets/textfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Fungsi untuk melakukan autentikasi
  Future<void> authenticateUser(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final currentContext = context;
    // Query ke tabel pengguna dengan email yang diinput pengguna
    final response = await supabase
        .from('pengguna')
        .select('username, password') // Mengambil kolom username dan password
        .eq('username', email) // Memeriksa apakah username cocok dengan email
        .single();

    // Jika response tidak null dan password cocok

    final user = response;
    final storedPassword = user['password'].toString();

    // Memeriksa apakah password cocok
    if (storedPassword == password) {
      // Jika cocok, izinkan pengguna untuk masuk ke halaman berikutnya
      Navigator.pushNamed(currentContext, '/main-page');
      return;
    }

    // Jika email atau password tidak cocok, tampilkan pesan kesalahan
    showDialog(
      context: currentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Email or password is incorrect.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: kPrimaryColor),
        ),
      ),
      backgroundColor: kWhiteColor,
      body: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH32,
            Text('Login',
                style: blackTextStyle.copyWith(fontSize: 28, fontWeight: bold)),
            gapH24,
            NewForm(
                controller: _emailController,
                nama: 'Email',
                hintText: 'Masukkan Email',
                obscureText: false,
                horizontalPadding: 0),
            gapH12,
            NewForm(
                controller: _passwordController,
                nama: 'Password',
                hintText: 'Masukkan Password',
                obscureText: true,
                horizontalPadding: 0),
            gapH32,
            Button(
                text: "Log In",
                textColor: kWhiteColor,
                startColor: kPrimaryColor,
                endColor: kPrimaryColor,
                onPressed: () {
                  authenticateUser(context);
                }),
          ],
        ),
      ),
    );
  }
}
