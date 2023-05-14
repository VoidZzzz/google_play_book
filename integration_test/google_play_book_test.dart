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

    final pumpAndSettle = await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Home Page
    expect(find.byType(BottomNavigationBarHomePage), findsOneWidget);
    
    /// Checking Datas in Home Page
    expect(find.text("Hardcover Nonfiction"), findsOneWidget);
    expect(find.text("Paperback Trade Fiction"), findsOneWidget);

    /// Navigate to Details for Book one
    await tester.tap(find.text(TEST_DATA_BOOK_NAME_ONE));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Checking Details for Book One
    expect(find.byKey(const ValueKey(TEST_DATA_BOOK_NAME_ONE_KEY)), findsOneWidget);
    expect(find.byKey(const ValueKey(TEST_DATA_AUTHOR_NAME_ONE_KEY)), findsOneWidget);

    /// Back to Home Page
    await tester.tap(find.byKey(const ValueKey("HomeBackButton")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Finding Book one in Carousel
    expect(find.byKey(const ValueKey(CHECK_CAROUSEL_BOOK)), findsOneWidget);

    /// Navigate to Details for Book Two
    await tester.tap(find.text(TEST_DATA_BOOK_NAME_TWO));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Checking Details for Book Two
    expect(find.byKey(const ValueKey(TEST_DATA_BOOK_NAME_ONE_KEY)), findsOneWidget);
    expect(find.byKey(const ValueKey(TEST_DATA_AUTHOR_NAME_ONE_KEY)), findsOneWidget);

    /// Back to Home Page
    await tester.tap(find.byKey(const ValueKey("HomeBackButton")));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Finding Book Two in Carousel
    expect(find.byKey(const ValueKey(CHECK_CAROUSEL_BOOK)), findsOneWidget);

    /// Navigate to Details for Book Three
    await tester.tap(find.text(TEST_DATA_BOOK_NAME_THREE));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Checking Details for Book Three
    expect(find.byKey(const ValueKey(TEST_DATA_BOOK_NAME_ONE_KEY)), findsOneWidget);
    expect(find.byKey(const ValueKey(TEST_DATA_AUTHOR_NAME_ONE_KEY)), findsOneWidget);

    /// Back to Home Page
    await tester.tap(find.byKey(const ValueKey("HomeBackButton")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Finding Book three in Carousel
    expect(find.byKey(const ValueKey(CHECK_CAROUSEL_BOOK)), findsOneWidget);

    /// Select Library Bottom Navigation Bar
    await tester.tap(find.byKey(const ValueKey("BottomNavLibrary")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    ///

    /// Tap View Layout Icon
    await tester.tap(find.byKey(const ValueKey("ViewLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Change Layout to Large Grid
    await tester.tap(find.byKey(const ValueKey("ViewTypeRadioTwo")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Check Large grid
    expect(find.byKey(const ValueKey("LargeGrid")), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Tap View Layout Icon
    await tester.tap(find.byKey(const ValueKey("ViewLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Change Layout to Small Grid
    await tester.tap(find.byKey(const ValueKey("ViewTypeRadioThree")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Check Large grid
    expect(find.byKey(const ValueKey("SmallGrid")), findsOneWidget);

    /// Tap View Layout Icon
    await tester.tap(find.byKey(const ValueKey("ViewLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Change Layout to List
    await tester.tap(find.byKey(const ValueKey("ViewTypeRadioOne")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Check Large grid
    expect(find.byKey(const ValueKey("listView")), findsOneWidget);

    /// Tap Sorting Layout Icon
    await tester.tap(find.byKey(const ValueKey("SortingLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Change Sort By To Author
    await tester.tap(find.byKey(const ValueKey("SortByRadioTwo")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Tap Sorting Layout Icon
    await tester.tap(find.byKey(const ValueKey("SortingLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Change Sort By To Title
    await tester.tap(find.byKey(const ValueKey("SortByRadioThree")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Tap Sorting Layout Icon
    await tester.tap(find.byKey(const ValueKey("SortingLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Change Sort By To Recent
    await tester.tap(find.byKey(const ValueKey("SortByRadioOne")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Filters
    await tester.tap(find.byKey(const ValueKey("Chip")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.byKey(const ValueKey("ClearButton")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Tap YourShelves Tab
    await tester.tap(find.text("Your Shelves"));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Tap Create Shelf Button
    await tester.tap(find.byKey(const ValueKey("CreateButton")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Create First Shelf
    await tester.enterText(find.byKey(const ValueKey("TextField")), "Educational");
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.text("Educational"), findsOneWidget);

    /// Add Books to First Shelf from Home
    await tester.tap(find.byKey(const ValueKey("BottomNavHome")));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(find.byKey(const ValueKey(TEST_DATA_BOOK_NAME_ONE)));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(find.byKey(const ValueKey("AddToShelf")));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(find.byKey(const ValueKey("Educational")));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(find.byKey(const ValueKey("Done")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Add Books from Library
    await tester.tap(find.byKey(const ValueKey("BottomNavLibrary")));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(find.byKey(const ValueKey(TEST_DATA_BOOK_NAME_TWO)));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(find.byKey(const ValueKey("AddToShelf")));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(find.byKey(const ValueKey("Educational")));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(find.byKey(const ValueKey("Done")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Your Shelf to Shelf Details
    await tester.tap(find.text("Your Shelves"));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(find.byKey(const ValueKey("Educational")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Shelf Filters and Views
    /// Tap View Layout Icon
    await tester.tap(find.byKey(const ValueKey("ViewLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Change Layout to Large Grid
    await tester.tap(find.byKey(const ValueKey("ViewTypeRadioTwo")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Check Large grid
    expect(find.byKey(const ValueKey("LargeGrid")), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Tap View Layout Icon
    await tester.tap(find.byKey(const ValueKey("ViewLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Change Layout to Small Grid
    await tester.tap(find.byKey(const ValueKey("ViewTypeRadioThree")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Check Large grid
    expect(find.byKey(const ValueKey("SmallGrid")), findsOneWidget);

    /// Tap View Layout Icon
    await tester.tap(find.byKey(const ValueKey("ViewLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Change Layout to List
    await tester.tap(find.byKey(const ValueKey("ViewTypeRadioOne")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Check Large grid
    expect(find.byKey(const ValueKey("listView")), findsOneWidget);

    /// Tap Sorting Layout Icon
    await tester.tap(find.byKey(const ValueKey("SortingLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Change Sort By To Author
    await tester.tap(find.byKey(const ValueKey("SortByRadioTwo")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Tap Sorting Layout Icon
    await tester.tap(find.byKey(const ValueKey("SortingLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Change Sort By To Title
    await tester.tap(find.byKey(const ValueKey("SortByRadioThree")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Tap Sorting Layout Icon
    await tester.tap(find.byKey(const ValueKey("SortingLayoutKey")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Change Sort By To Recent
    await tester.tap(find.byKey(const ValueKey("SortByRadioOne")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Filters
    await tester.tap(find.byKey(const ValueKey("Chip")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.byKey(const ValueKey("ClearButton")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Rename
    await tester.tap(find.byKey(const ValueKey("MenuButton")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.byKey(const ValueKey("Rename")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.enterText(find.byKey(const ValueKey("TextField")), "Sports");
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.text("Sports"));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.byKey(const ValueKey("MenuButton")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.byKey(const ValueKey("Delete")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    /// Search Page
    await tester.tap(find.byKey(const ValueKey("GoToSearch")));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.enterText(find.byKey(const ValueKey("SearchField")), "Flutter");
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(const Duration(seconds: 5));

  });
}
