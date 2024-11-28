import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoriteController extends GetxController {
  var favoriteSongs = <SongModel>[].obs; // Observable list to store favorite songs

  // Check if a song is already in favorites
  bool isFavorite(SongModel song) {
    return favoriteSongs.any((favSong) => favSong.id == song.id);
  }

  // Add or remove a song from favorites with snackbar notifications
  void toggleFavorite(SongModel song) {
    if (isFavorite(song)) {
      favoriteSongs.removeWhere((favSong) => favSong.id == song.id);
      Get.snackbar(
        'Removed',
        '${song.title} removed from liked songs',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    } else {
      favoriteSongs.add(song);
      Get.snackbar(
        'Added',
        '${song.title} added to liked songs',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    }
  }
}

