import 'package:flutter/cupertino.dart';

import '../data/data_vos/books_vo.dart';
import '../data/data_vos/shelf_vo.dart';
import '../data/models/google_play_book_model.dart';
import '../data/models/google_play_book_model_impl.dart';

class YourBooksBloc extends ChangeNotifier{

  int viewTypeValue = 1;
  List<String> categoryChipLabels = [];
  List<bool> chipIsSelected = [];
  List<ShelfVO>? shelfList;

  GooglePlayBookModel model = GooglePlayBookModelImpl();
  List<BooksVO>? savedBookList;
  bool isShowClearButton = false;

  YourBooksBloc(){
    /// getAllShelves from DB
    model.getAllShelves().then((response) {
      shelfList = response;
      notifyListeners();
    });

    /// getAllBooks from DB
    model.getSavedAllBooks().then((value) {
      savedBookList = value;
      print('----------------------> save books list  ${savedBookList?.length}');
      chipList();
      notifyListeners();
    });
  }

  void chipList() {
    print('----------------------> chip list');
    if (savedBookList != null) {
      for (int i = 0; i < savedBookList!.length; i++) {
        if (!(categoryChipLabels.contains(savedBookList?[i].categoryName)) &&
            savedBookList?[i].categoryName != null) {
          categoryChipLabels.add(savedBookList?[i].categoryName ?? "");
          chipIsSelected.add(false);
          notifyListeners();
        }
      }
    }
  }

  void setViewTypeValue({required int val}){
    viewTypeValue = val;
    notifyListeners();
  }

  void setSelectedChipIndex({required int index,required bool isSelected}){
    chipIsSelected[index] = isSelected;
    notifyListeners();
  }

  void showClearBtn({required bool value}){
    isShowClearButton = value;
    notifyListeners();
  }
}