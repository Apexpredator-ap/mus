import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/music_model.dart';
import '../views/homepage.dart';

class SplashController extends GetxController {
  var songsList = <MusicModel>[].obs;  // Observable list for fetched songs

  Future<void> checkPermissionAndFetchSongs() async {
    var status = await Permission.storage.request();  // Request storage permission

    if (status.isGranted) {
      await fetchSongs();
      if (songsList.isEmpty) {
        Get.snackbar(
          "No Songs Found",
          "Please add songs to your device.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.off(() => HomePage());  // Navigate to the home page
      }
    } else {
      Get.snackbar(
        "Permission Required",
        "Storage access is needed to show songs.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchSongs() async {
    try {
      List<MusicModel> fetchedSongs = await getAllSongsFromDevice();
      songsList.assignAll(fetchedSongs);
    } catch (e) {
      print("Error fetching songs: $e");
    }
  }

  // Placeholder for song-fetching logic
  Future<List<MusicModel>> getAllSongsFromDevice() async {
    // Simulated delay
    await Future.delayed(const Duration(seconds: 2));
    return [];  // Simulated empty list
  }
}

