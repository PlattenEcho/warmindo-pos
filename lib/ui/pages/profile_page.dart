import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_pos/model/pengguna.dart';
import 'package:warmindo_pos/services/shared_preferences.dart';
import 'package:warmindo_pos/ui/pages/start_screen.dart';
import 'package:warmindo_pos/ui/shared/theme.dart';
import 'package:warmindo_pos/ui/widgets/toast.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Pengguna? pengguna;

  @override
  void initState() {
    super.initState();
    loadCurrentUser();
  }

  void loadCurrentUser() async {
    final user = await UserPreferences.getUser();
    setState(() {
      pengguna = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: kWhiteColor,
      padding: EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Username: ${pengguna?.username ?? "N/A"}',
          ),
          ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
                backgroundColor: MaterialStateProperty.all(kRedColor),
                minimumSize:
                    const MaterialStatePropertyAll(Size(double.infinity, 50))),
            child: Text("Log Out",
                style: whiteTextStyle.copyWith(fontWeight: bold)),
            onPressed: () {
              UserPreferences.clearUser();
              showToast(context, "Log Out berhasil, silahkan Log In kembali");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const StartScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
