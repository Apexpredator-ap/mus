import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../db/db_helper.dart';
import '../models/playlist_model.dart';

class PlaylistController extends GetxController {
  RxList<Playlist> playlists = <Playlist>[].obs;
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    _loadPlaylists();
  }

  // Load playlists from the database
  void _loadPlaylists() async {
    playlists.value = await dbHelper.getPlaylists();
  }

  // Create a new playlist
  void createPlaylist(String playlistName) async {
    playlistName = playlistName.trim();

    if (playlistName.isEmpty) {
      Get.snackbar(
        'Error',
        'Playlist name cannot be empty',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (playlists.any((playlist) =>
        playlist.name.toLowerCase() == playlistName.toLowerCase())) {
      Get.snackbar(
        'Error',
        'Playlist with this name already exists',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    final newPlaylist = Playlist(name: playlistName, songs: []);
    final id = await dbHelper.insertPlaylist(newPlaylist);
    newPlaylist.id = id;

    playlists.add(newPlaylist);

    Get.snackbar(
      'Success',
      'Playlist "$playlistName" created',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  // Delete a playlist
  void deletePlaylist(Playlist playlist) async {
    await dbHelper.deletePlaylist(playlist.id!);
    playlists.remove(playlist);

    Get.snackbar(
      'Success',
      'Playlist "${playlist.name}" deleted',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  void addSongToPlaylist(Playlist playlist, SongModel song) {
    if (!playlist.songs.any((s) => s.id == song.id)) {
      playlist.songs.add(song);
      playlists.refresh(); // Ensure the UI updates
      Get.snackbar(
        'Success',
        'Song added to "${playlist.name}"',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'Song already exists in "${playlist.name}"',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  void removeSongFromPlaylist(Playlist playlist, SongModel song) {
    playlist.songs.removeWhere((s) => s.id == song.id);
    Get.snackbar(
      'Success',
      'Song removed from "${playlist.name}"',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
    );
  }
}



