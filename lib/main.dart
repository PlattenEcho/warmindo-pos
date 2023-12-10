import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warmindo_pos/ui/pages/detail_page.dart';
import 'package:warmindo_pos/ui/pages/login_page.dart';
import 'package:warmindo_pos/ui/pages/main_page.dart';
import 'package:warmindo_pos/ui/pages/start_screen.dart';

import 'cubit/page_cubit.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, routes: {
        '/': (context) => const StartScreen(),
        '/login-page': (context) => const LoginPage(),
        '/main-page': (context) => const MainPage(),
        '/detail-page': (context) => const DetailPage(
              status: 0,
              date: "",
              transactionID: "",
              noMeja: "",
              namaPelanggan: "",
              total: "",
              metodePembayaran: "",
            ),
      }),
    );
  }
}
