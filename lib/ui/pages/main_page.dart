import 'package:flutter/material.dart';
import 'package:warmindo_pos/ui/pages/dashboard_page.dart';
import 'package:warmindo_pos/ui/pages/profile_page.dart';
import 'package:warmindo_pos/ui/pages/transaksi_page.dart';
import 'package:warmindo_pos/ui/shared/theme.dart';

class MainPage extends StatefulWidget {
  final int pageIndex;
  const MainPage({
    super.key,
    required this.pageIndex,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime tanggal = DateTime.now();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.pageIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    DashboardPage(),
    TransaksiPage(),
    ProfilePage(),
  ];

  static const List<String> _appBarTitle = <String>[
    'Dashboard',
    'Transaksi',
    'Profile'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              color: kWhiteColor,
              child: Text(_appBarTitle[_selectedIndex],
                  style: blackTextStyle.copyWith(
                      fontSize: 24, fontWeight: extraBold)),
            ),
          )),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          elevation: 10.0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Dashboard',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_rounded),
              label: 'Transaksi',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.black,
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: kBlackColor,
          selectedItemColor: kPrimaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
