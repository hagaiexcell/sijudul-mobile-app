import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_project_skripsi/ui/ajukan_judul.dart';
import 'package:flutter_project_skripsi/ui/home.dart';
import 'package:flutter_project_skripsi/ui/profile.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedPageIndex = 0;
  final List _pageOption = [Home()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/ajukan': (context) => const AjukanJudul()
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    const AjukanJudul(),
    const Profile(),
    // tambahkan layar-layar lain di sini sesuai kebutuhan Anda
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: ConvexAppBar(
          height: 64,
          backgroundColor: AppColors.primary,
          items: const [
            TabItem(icon: Icons.home_filled, title: 'Beranda'),
            TabItem(icon: Icons.add_circle_rounded, title: 'Ajukan'),
            TabItem(icon: Icons.person, title: 'Profile'),
          ],
          onTap: (int i) => setState(() {
            _selectedIndex = i;
          }),
        ));
  }
}
