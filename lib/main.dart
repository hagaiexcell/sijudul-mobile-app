import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skripsi/features/dosen/bloc/dosen1_bloc.dart';
import 'package:flutter_project_skripsi/features/dosen/ui/dosen_1_page.dart';
import 'package:flutter_project_skripsi/features/home/ui/home_page.dart';
import 'package:flutter_project_skripsi/features/login/bloc/login_bloc.dart';
import 'package:flutter_project_skripsi/features/login/ui/login_page.dart';
import 'package:flutter_project_skripsi/features/posts/bloc/posts_bloc.dart';
import 'package:flutter_project_skripsi/features/posts/ui/posts_page.dart';
import 'package:flutter_project_skripsi/features/profile/bloc/profile_bloc.dart';
import 'package:flutter_project_skripsi/features/profile/ui/profile_page.dart';

import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_project_skripsi/ui/ajukan_judul.dart';
import 'package:flutter_project_skripsi/ui/detail_judul.dart';
import 'package:flutter_project_skripsi/ui/home.dart';
import 'package:flutter_project_skripsi/ui/list_dosen_1.dart';
import 'package:flutter_project_skripsi/ui/list_judul.dart';
import 'package:flutter_project_skripsi/ui/login_screen.dart';
import 'package:flutter_project_skripsi/ui/profile.dart';
import 'package:flutter_project_skripsi/ui/register_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_project_skripsi/ui/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  dotenv.load();
  // final prefs = await SharedPreferences.getInstance();
  // await prefs.remove('auth_token');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedPageIndex = 0;
  final List _pageOption = [HomePage()];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PostsBloc>(create: (context) => PostsBloc()),
          BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
          BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
          BlocProvider<Dosen1Bloc>(create: (context) => Dosen1Bloc()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Poppins',
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/home': (context) => MainScreen(),
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterScreen(),
            '/ajukan': (context) => AjukanJudul(),
            '/detail-judul': (context) => const DetailJudul(),
            // '/list-judul': (context) => ListJudul(),
            '/list-judul': (context) => PostsPage(),
            '/list-dosen-1': (context) => Dosen1Page(),
          },
        ));
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    AjukanJudul(),
    const ProfilePage(),
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
