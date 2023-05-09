import 'package:dio/dio.dart';
import 'package:google_play_book/network/api_constants.dart';
import 'package:google_play_book/network/response/get_google_search_response.dart';
import 'package:retrofit/http.dart';

part 'google_search_api.g.dart';

@RestApi(baseUrl: BASE_URL_GOOGLE)
abstract class GoogleSearchApi {
  factory GoogleSearchApi(Dio dio) = _GoogleSearchApi;

  @GET(ENDPOINT_GET_GOOGLE_SEARCH)
  Future<GetGoogleSearchResponse> getGoogleSearch(
    @Query(PARAM_Q) String keyWords,
  );
}
