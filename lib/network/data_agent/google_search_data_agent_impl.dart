import 'package:dio/dio.dart';
import 'package:google_play_book/network/data_agent/google_search_data_agent.dart';
import 'package:google_play_book/network/response/get_google_search_response.dart';

import '../google_search_api.dart';

class GoogleSearchDataAgentImpl extends GoogleSearchDataAgent{

  late GoogleSearchApi gApi;

  static final GoogleSearchDataAgentImpl _singleton = GoogleSearchDataAgentImpl._internal();

  factory GoogleSearchDataAgentImpl(){
    return _singleton;
  }

  GoogleSearchDataAgentImpl._internal() {
    final dio = Dio();
    gApi = GoogleSearchApi(dio);
  }
  @override
  Future<GetGoogleSearchResponse> getGoogleSearch(String keyWords) {
    return gApi.getGoogleSearch(keyWords);
  }
}