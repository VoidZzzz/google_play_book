import 'package:flutter/foundation.dart';
import '../data/data_vos/books_vo.dart';
import '../data/models/google_play_book_model.dart';
import '../data/models/google_play_book_model_impl.dart';
import '../data/models/google_search_model.dart';
import '../data/models/google_search_model_impl.dart';

class SearchBloc extends ChangeNotifier{
  /// States
  bool onChanged = false;
  bool onSubmit = false;
  List<BooksVO>? savedBookList;
  List<BooksVO>? searchItems;

  /// Models
  GooglePlayBookModel model = GooglePlayBookModelImpl();
  GoogleSearchModel gModel = GoogleSearchModelImpl();

  SearchBloc() {
    /// persistence layer
    model.getSavedAllBooks().then((value) {
        savedBookList = value;
        notifyListeners();
    });
  }

  /// GoogleSearch Api
  void getGoogleSearch(String text){
    gModel.getGoogleSearch(text)?.then((searchResponse) {
      searchItems = searchResponse;
      notifyListeners();
      print("======> searar c ${searchItems?.first.title}");
    });
  }

  void onUserSubmit() {
    onSubmit = true;
    notifyListeners();
  }

}