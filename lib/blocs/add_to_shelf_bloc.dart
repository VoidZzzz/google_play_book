import 'package:flutter/foundation.dart';
import 'package:google_play_book/data/data_vos/books_vo.dart';
import 'package:google_play_book/persistence/daos/shelf_dao.dart';

import '../data/data_vos/shelf_vo.dart';
import '../data/models/google_play_book_model.dart';
import '../data/models/google_play_book_model_impl.dart';

class AddToShelfBloc extends ChangeNotifier{

  /// Model
  GooglePlayBookModel model = GooglePlayBookModelImpl();
  ShelfDao shelfDao = ShelfDao();

  /// State Variable
  List<ShelfVO>? allShelf;
  bool isDisposed = false;

  AddToShelfBloc(){
    /// getAllShelves From Database
    model.getAllShelvesStream().listen((value) {
        allShelf = value;
        notifyListeners();
    });

    /// setting all values of selected bool to false
    shelfDao.getAllShelvesStream().listen((event) {
      event.map((e) {e.isSelected = false;
      print('-------------------> ${e.isSelected}');
      });
      notifyListeners();
      print("-----> >allll false");
    });

  }
  void addBookToSelectedShelves(BooksVO selectedBook){
    model.addBookToShelf(selectedBook);
    notifyListeners();
  }

  void checkNotifyListener() {
      notifyListeners();
  }

  void clearDisposeNotify() {
    print('AddToShelf Disposed');
      isDisposed = true;

  }


}