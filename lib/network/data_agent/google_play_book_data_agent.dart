
import '../response/get_overview_response.dart';

abstract class GooglePlayBookDataAgent {
Future<GetOverviewResponse> getOverview(String apiKey);
}