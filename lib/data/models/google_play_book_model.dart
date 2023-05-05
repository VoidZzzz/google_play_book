import '../../network/response/get_overview_response.dart';

abstract class GooglePlayBookModel {
Future<GetOverviewResponse> getOverview(String apiKey);
}