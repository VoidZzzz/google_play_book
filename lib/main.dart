import 'package:flutter/material.dart';
import 'package:google_play_book/data/data_vos/books_vo.dart';
import 'package:google_play_book/pages/bottom_navigation_bar_home_page.dart';
import 'package:google_play_book/persistence/hive_constant.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'data/data_vos/buy_links_vo.dart';
import 'data/data_vos/shelf_vo.dart';

void main() async{
  await Hive.initFlutter();

  Hive.registerAdapter(BuyLinkVOAdapter());
  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(ShelfVOAdapter());

  await Hive.openBox<BooksVO>(BOX_NAME_BOOK_VO);
  await Hive.openBox<ShelfVO>(BOX_NAME_SHELF_VO);
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
        scaffoldBackgroundColor: WHITE_COLOR,
        appBarTheme: const AppBarTheme(
            color: WHITE_COLOR, elevation: 0.0, centerTitle: true),
      ),
      home: const BottomNavigationBarHomePage(),
    );
  }
}
// flutter packages run build_runner build