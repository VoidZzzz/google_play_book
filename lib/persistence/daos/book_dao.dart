import 'package:google_play_book/data/data_vos/books_vo.dart';
import 'package:google_play_book/persistence/hive_constant.dart';
import 'package:hive/hive.dart';

class BookDao{
  static final BookDao _singleton = BookDao._internal();

  factory BookDao(){
    return _singleton;
  }

  BookDao._internal();

  void saveBook(BooksVO book) async {
    print('----------------------> Books Saved');
    return getBookBox().put(book.title, book);
  }

  List<BooksVO> getAllSavedBooks() {
    return getBookBox().values.toList();
  }

  Stream<List<BooksVO>> getAllSavedBooksStream() {
    return Stream.value(getAllSavedBooks());
  }

  Stream<void> getAllSavedBooksEventStream(){
    return getBookBox().watch();
  }

  Box<BooksVO> getBookBox(){
    return Hive.box<BooksVO>(BOX_NAME_BOOK_VO);
  }
}