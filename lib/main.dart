import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/pages/bottom_navigation_bar_home_page.dart';
import 'package:google_play_book/resources/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: APP_PRIMARY_COLOR,
        appBarTheme: const AppBarTheme(
            color: APP_PRIMARY_COLOR, elevation: 0.0, centerTitle: true),
      ),
      home: const BottomNavigationBarHomePage(),
    );
  }
}
