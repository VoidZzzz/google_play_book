import 'package:flutter/material.dart';
import 'package:google_play_book/data/data_vos/books_vo.dart';

import '../data/models/google_play_book_model.dart';
import '../data/models/google_play_book_model_impl.dart';

class DetailBloc extends ChangeNotifier{
  bool seeMoreIsTapped = false; // <==== Ebook details SEE MORE flag
  bool isDisposed = false;
  GooglePlayBookModel model = GooglePlayBookModelImpl();

  void saveBook({required BooksVO? book}){
    model.saveBook(book!);
    notifyListeners();
  }

  void setMoreOrLessStatus(){
    seeMoreIsTapped = !seeMoreIsTapped;
    notifyListeners();
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