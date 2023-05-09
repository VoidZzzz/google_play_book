import '../response/get_google_search_response.dart';

abstract class GoogleSearchDataAgent{
  Future<GetGoogleSearchResponse> getGoogleSearch(String keyWords);
}