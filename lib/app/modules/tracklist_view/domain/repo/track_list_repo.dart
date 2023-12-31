import 'package:tune_pulse/app/modules/tracklist_view/domain/api/track_list_api.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';

class TrackListRepository extends TrackListApi {
  Future<List<Track>> repoGetTrackList(int limit, int nextPage) async {
    final response = await apiGetTrackList(limit, nextPage);
    if (response != null) {
      try {
        final List<Track> listofTracks =
            List.from(response).map((e) => Track.fromJson(e)).toList();
        return listofTracks;
      } catch (e) {
        throw e.toString();
      }
    }
    return [];
  }
}
