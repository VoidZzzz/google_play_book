import 'package:google_play_book/data/data_vos/books_vo.dart';

import '../../network/response/get_google_search_response.dart';

abstract class GoogleSearchModel{
  Future<List<BooksVO>>? getGoogleSearch(String keyWords);
}