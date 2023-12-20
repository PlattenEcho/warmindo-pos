import 'package:flutter/material.dart';
import 'package:warmindo_pos/crypt.dart';
import 'package:warmindo_pos/main.dart';
import 'package:warmindo_pos/ui/shared/gaps.dart';
import 'package:warmindo_pos/ui/shared/theme.dart';
import 'package:warmindo_pos/ui/widgets/button.dart';
import 'package:warmindo_pos/ui/widgets/textfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:warmindo_pos/ui/widgets/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> authenticateUser(
      BuildContext context, String username, String password) async {
    final response = await supabase
        .from('pengguna')
        .select('username, password')
        .eq('username', username)
        .single();

    if (response != null) {
      final user = response;
      String storedPassword = user['password'].toString();
      storedPassword = decryptMyData(storedPassword);

      if (storedPassword == password) {
        Navigator.pushNamed(context, '/main-page');
      } else {
        showToast(context, "Username atau Password yang anda masukkan salah");
      }
    } else {
      showToast(context, "Username atau Password yang anda masukkan salah");
    }
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
                controller: _usernameController,
                nama: 'Username',
                hintText: 'Masukkan Username',
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
                  String username = _usernameController.text.trim();
                  String password = _passwordController.text.trim();
                  authenticateUser(context, username, password);
                }),
          ],
        ),
      ),
    );
  }
}
