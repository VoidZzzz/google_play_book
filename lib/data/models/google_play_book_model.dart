import 'package:google_play_book/network/response/get_more_list_response.dart';

import '../../network/response/get_overview_response.dart';

abstract class GooglePlayBookModel {
Future<GetOverviewResponse> getOverview(String apiKey);
Future<GetMoreListResponse> getMoreList(String apiKey, String list, String offset);
}