import 'package:flutter/foundation.dart';
import 'package:google_play_book/data/models/google_play_book_model.dart';
import 'package:google_play_book/data/models/google_play_book_model_impl.dart';

import '../data/data_vos/books_vo.dart';
import '../data/data_vos/lists_vo.dart';
import '../network/api_constants.dart';

class HomeBloc extends ChangeNotifier {
  /// Model
  final GooglePlayBookModel _bookModel = GooglePlayBookModelImpl();

  /// State Variable
  List<ListsVO>? bookList;
  List<BooksVO>? saveBookList;
  bool isDisposed = false;

  HomeBloc(){
    /// network
    _bookModel.getOverview(API_KEY).then((response) {
        bookList = response.results?.lists;
        checkNotifyListener();
      debugPrint("===========> ${bookList?[2].books?.last.categoryName}");
    }).catchError(
          (error) {
        debugPrint(
          error.toString(),
        );
      },
    );

    /// Persistence
    _bookModel.getSaveBookListStream().listen((value) {
      value.sort((a, b) => (a.saveTime ?? 0).compareTo(b.saveTime ?? 0));
      saveBookList = value.reversed.toList();
      checkNotifyListener();
    });
  }

  void checkNotifyListener() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  void clearDisposeNotify() {
    if (!isDisposed) {
      isDisposed = true;
    }
  }

}
