import 'package:flutter/material.dart';
import 'package:warmindo_pos/ui/pages/start_screen.dart';
import 'package:warmindo_pos/ui/shared/gaps.dart';
import 'package:warmindo_pos/ui/shared/theme.dart';
import 'package:warmindo_pos/ui/widgets/button.dart';
import 'package:warmindo_pos/ui/widgets/textfield.dart';

import '../../services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StartScreen()),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kWhiteColor,
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StartScreen()),
              );
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
                  style:
                      blackTextStyle.copyWith(fontSize: 28, fontWeight: bold)),
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
      ),
    );
  }
}
