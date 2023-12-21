import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmindo_pos/ui/pages/login_page.dart';
import 'package:warmindo_pos/ui/shared/gaps.dart';
import 'package:warmindo_pos/ui/shared/theme.dart';
import 'package:warmindo_pos/ui/widgets/button.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/bg_start.png',
                  ),
                  fit: BoxFit.cover)),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.height / 1.8),
              ),
              Expanded(
                  child: Column(
                children: [
                  Text(
                    'Warmindo POS',
                    style: whiteTextStyle.copyWith(
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                        fontFamily: GoogleFonts.poppins().fontFamily),
                  ),
                  Text(
                    'Point of Sales System',
                    style: whiteTextStyle.copyWith(
                        fontSize: 18, fontWeight: regular),
                  ),
                ],
              )),
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Button(
                        text: "Masuk",
                        textColor: kWhiteColor,
                        startColor: kPrimaryColor,
                        endColor: kPrimaryColor,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        }),
                    gapH(21),
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
