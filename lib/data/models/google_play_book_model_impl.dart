import 'package:google_play_book/data/data_vos/books_vo.dart';
import 'package:google_play_book/data/data_vos/shelf_vo.dart';
import 'package:google_play_book/data/models/google_play_book_model.dart';
import 'package:google_play_book/network/response/get_more_list_response.dart';
import 'package:google_play_book/network/response/get_overview_response.dart';
import 'package:google_play_book/persistence/daos/book_dao.dart';
import '../../network/data_agent/google_play_book_data_agent.dart';
import '../../network/data_agent/google_play_book_data_agent_impl.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../persistence/daos/shelf_dao.dart';

class GooglePlayBookModelImpl extends GooglePlayBookModel {
  static final GooglePlayBookModelImpl _singleton =
      GooglePlayBookModelImpl._internal();

  factory GooglePlayBookModelImpl() {
    return _singleton;
  }

  GooglePlayBookModelImpl._internal();

  final GooglePlayBookDataAgent _dataAgent = GooglePlayBookDataAgentImpl();
  final BookDao _bookDao = BookDao();
  final ShelfDao _shelfDao = ShelfDao();

  @override
  Future<GetOverviewResponse> getOverview(String apiKey) {
    return _dataAgent.getOverview(apiKey).then((response) {
      for (int i = 0; i < response.results!.lists!.length; i++) {
        for (int j = 0; j < response.results!.lists![i].books!.length; j++) {
          response.results?.lists?[i].books?[j].categoryName =
              response.results?.lists?[i].displayName;
        }
      }
      return response;
    });
  }

  @override
  Future<GetMoreListResponse> getMoreList(
      String apiKey, String list, String offset) {
    return _dataAgent.getMoreList(apiKey, list, offset);
  }

  @override
  Future<void> saveBook(BooksVO book) async {
    book.saveTime = DateTime.now().microsecondsSinceEpoch;
    _bookDao.saveBook(book);
  }

  @override
  Future<List<BooksVO>> getSavedAllBooks() {
    return Future.value(
      _bookDao.getAllSavedBooks(),
    );
  }

  @override
  Future<void> createShelf(ShelfVO shelf) async {
    _shelfDao.createShelf(shelf);
  }

  @override
  Future<List<ShelfVO>> getAllShelves() {
    return Future.value(
      _shelfDao.getAllShelves(),
    );
  }

  @override
  Stream<List<BooksVO>> getSaveBookListStream() {
    return _bookDao
        .getAllSavedBooksEventStream()
        .startWith(
          _bookDao.getAllSavedBooksStream(),
        )
        .map(
          (event) => _bookDao.getAllSavedBooks(),
        );
  }

  @override
  Stream<List<ShelfVO>> getAllShelvesStream() {
    return _shelfDao
        .getAllShelvesEventStream()
        .startWith(
          _shelfDao.getAllShelvesStream(),
        )
        .map(
          (event) => _shelfDao.getAllShelves(),
        );
  }

  @override
  void addBookToShelf(BooksVO book) {
    _shelfDao.addBookToShelf(book);
  }

  @override
  void deleteShelf(int shelfId) {
    _shelfDao.deleteShelf(shelfId);
  }

  @override
  Future<ShelfVO> renameShelf(int shelfId, String newName) {
    return Future.value(
      _shelfDao.renameShelf(shelfId, newName),
    );
  }
}
