import 'package:dio/dio.dart';
import 'package:google_play_book/network/api_constants.dart';
import 'package:google_play_book/network/response/get_overview_response.dart';
import 'package:retrofit/retrofit.dart';

part 'google_play_book_api.g.dart';

@RestApi(baseUrl: BASE_URL_NYTIMES)
abstract class GooglePlayBookApi {
  factory GooglePlayBookApi(Dio dio) = _GooglePlayBookApi;

  @GET(ENDPOINT_GET_OVERVIEW)
  Future<GetOverviewResponse> getOverview(
    @Query(PARAM_API_KEY) String apiKey,
  );


}
