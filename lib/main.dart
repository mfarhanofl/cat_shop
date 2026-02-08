import 'package:zomo/Authentication/login.dart';
import 'package:zomo/Authentication/signup_screen.dart';
import 'package:zomo/Provider/cart_provider.dart';
import 'package:zomo/Provider/favirite_provider.dart';
import 'package:zomo/Screens/cart_screen.dart';
import 'package:zomo/Screens/favorite.dart';
import 'package:zomo/Screens/homepage.dart';
import 'package:zomo/Screens/profile_screen.dart';
import 'package:zomo/splashscreen.dart';
import 'package:zomo/widget/bottom_nav_bar.dart' show CustomBottomNav;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomo/widget/search_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavouriteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Splashscreen(),
        '/login': (context) => Login(),
        '/signup': (context) => Signup_Screen(),
        '/homepage': (context) => Homepage(),
        '/favorite': (context) => Favorite(),
        '/cart': (context) => CartScreen(),
        '/profile': (context) => ProfileScreen(),
        '/search': (context) => SearchScreen(),
        '/bottombar': (context) => CustomBottomNav(),
      },
    );
  }
}
