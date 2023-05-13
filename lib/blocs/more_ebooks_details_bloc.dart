import 'package:flutter/foundation.dart';

import '../data/data_vos/books_vo.dart';
import '../data/data_vos/more_list_results_vo.dart';
import '../data/models/google_play_book_model.dart';
import '../data/models/google_play_book_model_impl.dart';
import '../network/api_constants.dart';

class MoreEbooksDetailsBloc extends ChangeNotifier{

  /// Model
  GooglePlayBookModel model = GooglePlayBookModelImpl();
  bool isDisposed = false;

  /// State Variables
  List<MoreListResultsVO>? listsResults;
  BooksVO? bookDetails;

  MoreEbooksDetailsBloc(String listName){
    model.getMoreList(API_KEY, listName, "0-20").then((response) {
        listsResults = response.results;
        notifyListeners();
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