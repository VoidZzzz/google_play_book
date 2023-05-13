import 'package:flutter/foundation.dart';
import 'package:google_play_book/data/data_vos/shelf_vo.dart';

import '../data/data_vos/books_vo.dart';
import '../data/models/google_play_book_model.dart';
import '../data/models/google_play_book_model_impl.dart';

class ShelfDetailsBloc extends ChangeNotifier {
  int viewTypeValue = 1;
  bool isShowClearButton = false;
  List<BooksVO>? booksInShelf;
  List<String> categoryChipLabels = [];
  List<bool> selectedChipsList = [];
  GooglePlayBookModel model = GooglePlayBookModelImpl();
  bool isDisposed = false;
  List<BooksVO>? temp;
  List<BooksVO> tempCombined = [];
  bool isEditMode = false;

  ShelfDetailsBloc(ShelfVO shelf) {
    getBooksInShelf(shelf);
    checkNotifyListener();
  }

  void setEditModeToTrue(){
    isEditMode = true;
    checkNotifyListener();
  }

  void setEditModeToFalse(){
    isEditMode = false;
    checkNotifyListener();
  }

  void deleteShelf(int shelfId){
    model.deleteShelf(shelfId);
    checkNotifyListener();
  }

  void renameShelf(int shelfId, String newName){
    model.renameShelf(shelfId, newName);
    checkNotifyListener();
  }

  void getBooksInShelf(ShelfVO shelf) {
    booksInShelf = shelf.books;
    notifyListeners();
    chipList();
  }

  void chipList() {
    if (booksInShelf != null) {
      for (int i = 0; i < booksInShelf!.length; i++) {
        if (!(categoryChipLabels.contains(booksInShelf?[i].categoryName)) &&
            booksInShelf?[i].categoryName != null) {
          categoryChipLabels.add(booksInShelf?[i].categoryName ?? "");
          selectedChipsList.add(false);
          checkNotifyListener();
        }
      }
    }
  }

  void setViewTypeValue({required int val}) {
    viewTypeValue = val;
    checkNotifyListener();
  }

  void sortBookByType({required int val}) {
    setViewTypeValue(val: val);
    if (val == 1) {
      booksInShelf?.sort((a, b) => (a.saveTime ?? 0).compareTo(b.saveTime ?? 0));
      checkNotifyListener();
    } else if (val == 2) {
      booksInShelf?.sort((a, b) => (a.title ?? "").compareTo(b.title ?? ""));
      checkNotifyListener();
    } else if (val == 3) {
      booksInShelf?.sort((a, b) => (a.author ?? "").compareTo(b.author ?? ""));
      checkNotifyListener();
    }
  }

  void setSelectedChipIndex(
      {required int index, required bool isSelected}) async {
    selectedChipsList[index] = isSelected;
    await getBookByCategory(categoryChipLabels[index]);
    checkNotifyListener();
  }

  void showClearBtn({required bool value}) {
    isShowClearButton = value;
    checkNotifyListener();
  }

  void setToDefault(ShelfVO shelf) async {
    showClearBtn(value: false);
    selectedChipsList = selectedChipsList.map((e) => false).toList();
    tempCombined.clear();
    temp?.clear();
    getBooksInShelf(shelf);
    checkNotifyListener();
  }


  Future<void> getBookByCategory(String name) async {
    model.getSavedAllBooks().then((value) {
      temp = value.where((e) => e.categoryName == name).toList();
      tempCombined += temp ?? [];
      temp?.clear();
      booksInShelf = tempCombined.toSet().toList();
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
