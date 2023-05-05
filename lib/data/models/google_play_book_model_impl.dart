import 'package:google_play_book/data/models/google_play_book_model.dart';
import 'package:google_play_book/network/response/get_overview_response.dart';
import '../../network/data_agent/google_play_book_data_agent.dart';
import '../../network/data_agent/google_play_book_data_agent_impl.dart';

class GooglePlayBookModelImpl extends GooglePlayBookModel {
  static final GooglePlayBookModelImpl _singleton =
      GooglePlayBookModelImpl._internal();

  factory GooglePlayBookModelImpl() {
    return _singleton;
  }

  GooglePlayBookModelImpl._internal();

  final GooglePlayBookDataAgent _dataAgent = GooglePlayBookDataAgentImpl();

  @override
  Future<GetOverviewResponse> getOverview(String apiKey) {
    return _dataAgent.getOverview(apiKey);
  }
}
