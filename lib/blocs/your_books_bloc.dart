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
  bool isDisposed = false;
  int count = 0;

  YourBooksBloc(){
    /// getAllShelves from DB
    model.getAllShelvesStream().listen((event) {
      event.sort((a, b) => (a.shelfName ?? "").compareTo(b.shelfName ?? ""));
      shelfList = event.toList();
      checkNotifyListener();
    });

    /// getAllBooks from DB
    model.getSaveBookListStream().listen((value) {
      value.sort((a, b) => (a.saveTime ?? 0).compareTo(b.saveTime ?? 0));
      savedBookList = value.reversed.toList();
      chipList();
      checkNotifyListener();
    });
  }

  void chipList() {
    if (savedBookList != null) {
      for (int i = 0; i < savedBookList!.length; i++) {
        if (!(categoryChipLabels.contains(savedBookList?[i].categoryName)) &&
            savedBookList?[i].categoryName != null) {
          categoryChipLabels.add(savedBookList?[i].categoryName ?? "");
          chipIsSelected.add(false);
          checkNotifyListener();
        }
      }
    }
  }

  void setViewTypeValue({required int val}){
    viewTypeValue = val;
    checkNotifyListener();
  }

  void setSelectedChipIndex({required int index,required bool isSelected}){
    chipIsSelected[index - 1] = isSelected;
    checkNotifyListener();
  }

  void showClearBtn({required bool value}){
    isShowClearButton = value;
    checkNotifyListener();
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