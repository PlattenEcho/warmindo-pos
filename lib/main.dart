import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warmindo_pos/model/pengguna.dart';
import 'package:warmindo_pos/services/shared_preferences.dart';
import 'package:warmindo_pos/ui/pages/detail_page.dart';
import 'package:warmindo_pos/ui/pages/login_page.dart';
import 'package:warmindo_pos/ui/pages/main_page.dart';
import 'package:warmindo_pos/ui/pages/start_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:warmindo_pos/ui/pages/transaksi_by_dateshift.dart';
import 'package:warmindo_pos/ui/pages/transaksi_page.dart';

import 'cubit/page_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qdlampjhhlffnpqhtktr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFkbGFtcGpoaGxmZm5wcWh0a3RyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDIxMjUxMzMsImV4cCI6MjAxNzcwMTEzM30.-wyen0VL5IEkeV739cSzVGk5PjQXzu67qdyNm4dzcSg',
  );
  runApp(MainApp());
}

final supabase = Supabase.instance.client;

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
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FutureBuilder<Pengguna?>(
            future: UserPreferences.getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final user = snapshot.data;
                return user != null
                    ? MainPage(
                        pageIndex: 0,
                      )
                    : StartScreen();
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          routes: {
            '/login-page': (context) => const LoginPage(),
            '/main-page': (context) => const MainPage(
                  pageIndex: 0,
                ),
            '/transaksi-page': (context) => const TransaksiPage(),
            '/transaksi-dateshift': (context) => TransaksiByDateShift(
                  selectedIndex: 0,
                  tanggal: DateTime.now(),
                ),
            '/detail-page': (context) => DetailPage(
                  status: 0,
                  date: "",
                  transactionID: "",
                  noMeja: "",
                  namaPelanggan: "",
                  total: "",
                  metodePembayaran: "",
                  diskon: 0,
                  idOnly: 0,
                ),
          }),
    );
  }
}
