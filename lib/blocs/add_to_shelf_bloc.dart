import 'package:flutter/foundation.dart';
import 'package:google_play_book/data/data_vos/books_vo.dart';
import 'package:google_play_book/persistence/daos/shelf_dao.dart';

import '../data/data_vos/shelf_vo.dart';
import '../data/models/google_play_book_model.dart';
import '../data/models/google_play_book_model_impl.dart';

class AddToShelfBloc extends ChangeNotifier {
  /// Model
  GooglePlayBookModel model = GooglePlayBookModelImpl();
  ShelfDao shelfDao = ShelfDao();

  /// State Variable
  List<ShelfVO>? allShelf;
  bool isDisposed = false;

  AddToShelfBloc() {
    /// getAllShelves From Database
    model.getAllShelvesStream().listen((value) {
      allShelf = value;
      checkNotifyListener();
    });

    /// setting all values of selected bool to false
    setToDefault();
  }

  void setToDefault() {
   model.setToDefault();
  }

  void setSelectedShelf(int index) {
    allShelf?[index].isSelected = !(allShelf?[index].isSelected ?? false);
    checkNotifyListener();
  }

  void addBookToSelectedShelves(BooksVO selectedBook) {
    model.addBookToShelf(selectedBook);
    setToDefault();
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
