import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_play_book/data/data_vos/books_vo.dart';
import 'package:google_play_book/data/data_vos/buy_links_vo.dart';
import 'package:google_play_book/data/data_vos/shelf_vo.dart';
import 'package:google_play_book/main.dart';
import 'package:google_play_book/pages/bottom_navigation_bar_home_page.dart';
import 'package:google_play_book/pages/home_page.dart';
import 'package:google_play_book/persistence/hive_constant.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:integration_test/integration_test.dart';

import 'test_data/test_data.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(BuyLinkVOAdapter());
  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(ShelfVOAdapter());

  await Hive.openBox<BooksVO>(BOX_NAME_BOOK_VO);
  await Hive.openBox<ShelfVO>(BOX_NAME_SHELF_VO);

  testWidgets("Google Play Book UI Test", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await Future.delayed(const Duration(seconds: 3));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Home Page
    expect(find.byType(BottomNavigationBarHomePage), findsOneWidget);
    
    /// Checking Datas in Home Page
    expect(find.text("Hardcover Nonfiction"), findsOneWidget);
    expect(find.text("Paperback Trade Fiction"), findsOneWidget);

    // /// Navigate to Details for Book one
    // await tester.tap(find.text(TEST_DATA_BOOK_NAME_ONE));
    // await tester.pumpAndSettle(const Duration(seconds: 5));
    //
    // /// Checking Details for Book One
    // expect(find.byKey(const ValueKey(TEST_DATA_BOOK_NAME_ONE_KEY)), findsOneWidget);
    // expect(find.byKey(const ValueKey(TEST_DATA_AUTHOR_NAME_ONE_KEY)), findsOneWidget);
    //
    // /// Back to Home Page
    // await tester.tap(find.byKey(const ValueKey("HomeBackButton")));
    // await tester.pumpAndSettle(const Duration(seconds: 5));
    //
    // /// Finding Book one in Carousel
    // expect(find.byKey(const ValueKey("Carousel Book")), findsOneWidget);
    //
    // /// Navigate to Details for Book Two
    // await tester.tap(find.text(TEST_DATA_BOOK_NAME_TWO));
    // await tester.pumpAndSettle(const Duration(seconds: 5));
    //
    // /// Checking Details for Book Two
    // expect(find.byKey(const ValueKey(TEST_DATA_BOOK_NAME_ONE_KEY)), findsOneWidget);
    // expect(find.byKey(const ValueKey(TEST_DATA_AUTHOR_NAME_ONE_KEY)), findsOneWidget);
    //
    // /// Back to Home Page
    // await tester.tap(find.byKey(const ValueKey("HomeBackButton")));
    // await tester.pumpAndSettle(const Duration(seconds: 5));
    // await tester.pumpAndSettle(const Duration(seconds: 5));
    //
    // /// Finding Book three in Carousel
    // expect(find.byKey(const ValueKey("Carousel Book")), findsOneWidget);
    //
    // /// Navigate to Details for Book Three
    // await tester.tap(find.text(TEST_DATA_BOOK_NAME_THREE));
    // await tester.pumpAndSettle(const Duration(seconds: 5));
    //
    // /// Checking Details for Book Three
    // expect(find.byKey(const ValueKey(TEST_DATA_BOOK_NAME_ONE_KEY)), findsOneWidget);
    // expect(find.byKey(const ValueKey(TEST_DATA_AUTHOR_NAME_ONE_KEY)), findsOneWidget);
    //
    // /// Back to Home Page
    // await tester.tap(find.byKey(const ValueKey("HomeBackButton")));
    // await tester.pumpAndSettle(const Duration(seconds: 5));
    //
    // /// Finding Book three in Carousel
    // expect(find.byKey(const ValueKey("Carousel Book")), findsOneWidget);

    /// Select Library Bottom Navigation Bar
    await tester.tap(find.byKey(const ValueKey("BottomNavLibrary")));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    /// Tap View Layout Icon
    await tester.tap(find.byKey(const ValueKey("ViewLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    /// Change Layout to Large Grid
    await tester.tap(find.byKey(const ValueKey("ViewTypeRadioTwo")));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    /// Tap View Layout Icon
    await tester.tap(find.byKey(const ValueKey("ViewLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    /// Change Layout to Small Grid
    await tester.tap(find.byKey(const ValueKey("ViewTypeRadioThree")));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    /// Tap View Layout Icon
    await tester.tap(find.byKey(const ValueKey("ViewLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    /// Change Layout to List
    await tester.tap(find.byKey(const ValueKey("ViewTypeRadioOne")));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    /// Tap Sorting Layout Icon
    await tester.tap(find.byKey(const ValueKey("SortingLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    /// Change Sort By To Author
    await tester.tap(find.byKey(const ValueKey("SortByRadioTwo")));
    await tester.pumpAndSettle(const Duration(seconds: 7));

    /// Tap Sorting Layout Icon
    await tester.tap(find.byKey(const ValueKey("SortingLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 7));

    /// Change Sort By To Title
    await tester.tap(find.byKey(const ValueKey("SortByRadioThree")));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    /// Tap Sorting Layout Icon
    await tester.tap(find.byKey(const ValueKey("SortingLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 7));

    /// Change Sort By To Recent
    await tester.tap(find.byKey(const ValueKey("SortByRadioOne")));
    await tester.pumpAndSettle(const Duration(seconds: 7));
  });
}
