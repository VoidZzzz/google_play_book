import 'package:google_play_book/data/data_vos/books_vo.dart';
import 'package:google_play_book/data/models/google_play_book_model.dart';
import 'package:google_play_book/network/response/get_more_list_response.dart';
import 'package:google_play_book/network/response/get_overview_response.dart';
import 'package:google_play_book/persistence/daos/book_dao.dart';
import '../../network/data_agent/google_play_book_data_agent.dart';
import '../../network/data_agent/google_play_book_data_agent_impl.dart';
import 'package:stream_transform/stream_transform.dart';

class GooglePlayBookModelImpl extends GooglePlayBookModel {
  static final GooglePlayBookModelImpl _singleton =
      GooglePlayBookModelImpl._internal();

  factory GooglePlayBookModelImpl() {
    return _singleton;
  }

  GooglePlayBookModelImpl._internal();

  final GooglePlayBookDataAgent _dataAgent = GooglePlayBookDataAgentImpl();
  final BookDao _bookDao = BookDao();

  @override
  Future<GetOverviewResponse> getOverview(String apiKey) {
    return _dataAgent.getOverview(apiKey);
  }

  @override
  Future<GetMoreListResponse> getMoreList(String apiKey, String list, String offset) {
    return _dataAgent.getMoreList(apiKey,list, offset);
  }

  @override
  Future<void> saveBook(BooksVO book) async{
    book.saveTime = DateTime.now().microsecondsSinceEpoch;
    _bookDao.saveBook(book);
  }

  @override
  Future<List<BooksVO>> getSavedAllBooks() {
    return Future.value(_bookDao.getAllSavedBooks());
  }
}
