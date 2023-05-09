import 'package:google_play_book/data/data_vos/books_vo.dart';
import 'package:google_play_book/data/models/google_search_model.dart';
import 'package:google_play_book/network/response/get_google_search_response.dart';

import '../../network/data_agent/google_search_data_agent.dart';
import '../../network/data_agent/google_search_data_agent_impl.dart';

class GoogleSearchModelImpl extends GoogleSearchModel {
  static final GoogleSearchModelImpl _singleton =
      GoogleSearchModelImpl._internal();

  factory GoogleSearchModelImpl() {
    return _singleton;
  }

  GoogleSearchModelImpl._internal();

  final GoogleSearchDataAgent _dataAgent = GoogleSearchDataAgentImpl();

  @override
  Future<List<BooksVO>> getGoogleSearch(String keyWords) {
    List<BooksVO> list = [];
    return _dataAgent.getGoogleSearch(keyWords).then((response) {
      response.items?.forEach((element) {
        list.add(
          BooksVO(
              null,
              null,
              null,
              element.volumeInfo?.authors?.first,
              element.volumeInfo?.imageLinks?.thumbnail,
              null,
              null,
              null,
              null,
              null,
              null,
              element.volumeInfo?.description,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              element.volumeInfo?.title,
              element.volumeInfo?.publishedDate,
              null,
              null,
              element.volumeInfo?.categories?.first,
              null),
        );
      });
      return list;
    });
  }
}
