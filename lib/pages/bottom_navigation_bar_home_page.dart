import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/pages/home_page.dart';
import 'package:google_play_book/resources/colors.dart';
import '../widgets/default_app_bar_view.dart';
import 'library_page.dart';

class BottomNavigationBarHomePage extends StatefulWidget {
  const BottomNavigationBarHomePage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarHomePage> createState() =>
      _BottomNavigationBarHomePageState();
}

class _BottomNavigationBarHomePageState
    extends State<BottomNavigationBarHomePage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  final List<Widget> _body = [
    Homepage(),
    LibraryPage()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _body[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: WHITE_COLOR,
          selectedItemColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
          unselectedItemColor: Colors.black54,
          selectedLabelStyle:
              GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13),
          unselectedLabelStyle:
              GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13),
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: "Library"),
          ],
        ),
      ),
    );
  }
}
