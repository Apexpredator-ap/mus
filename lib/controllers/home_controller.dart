import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicController extends GetxController {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  var songs = <SongModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    requestPermission();
  }

  // Request permission to access audio files
  void requestPermission() async {
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
    }
    fetchSongs();
  }

  // Fetch the list of songs
  void fetchSongs() async {
    isLoading(true); // Set loading state to true
    List<SongModel> songList = await _audioQuery.querySongs();
    songs.assignAll(songList); // Update the song list
    isLoading(false); // Set loading state to false
  }
}
