
import '../response/get_more_list_response.dart';
import '../response/get_overview_response.dart';

abstract class GooglePlayBookDataAgent {
Future<GetOverviewResponse> getOverview(String apiKey);
Future<GetMoreListResponse> getMoreList(String apiKey, String list, String offset);
}