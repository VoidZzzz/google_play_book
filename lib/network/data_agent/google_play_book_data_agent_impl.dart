import 'package:dio/dio.dart';
import 'package:google_play_book/network/data_agent/google_play_book_data_agent.dart';
import 'package:google_play_book/network/google_play_book_api.dart';
import 'package:google_play_book/network/response/get_overview_response.dart';

class GooglePlayBookDataAgentImpl extends GooglePlayBookDataAgent {
  late GooglePlayBookApi mApi;

  static final GooglePlayBookDataAgentImpl _singleton =
      GooglePlayBookDataAgentImpl._internal();

  factory GooglePlayBookDataAgentImpl() {
    return _singleton;
  }

  GooglePlayBookDataAgentImpl._internal() {
    final dio = Dio();
    mApi = GooglePlayBookApi(dio);
  }

  @override
  Future<GetOverviewResponse> getOverview(String apiKey) {
    return mApi.getOverview(apiKey);
  }
}
