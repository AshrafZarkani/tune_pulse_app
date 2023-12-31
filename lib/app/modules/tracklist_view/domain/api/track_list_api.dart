import '../../../../core/constants/barrel_constants.dart';
import '../../../../services/barrel_services.dart';

class TrackListApi extends MyApiPaths {
  final HttpCrudClient _httpCrudClient = HttpCrudClient();
  Future<dynamic> apiGetTrackList(int limit,int nextPage) async {
    try {
      final response = await _httpCrudClient.get("$topSongs?limit=$limit&index=$nextPage");
      return response['tracks']['data'];
    } catch (e) {
      throw e.toString();
    }
  }
}
