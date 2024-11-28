// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:on_audio_query/on_audio_query.dart';
//
// class PlayerController extends GetxController {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//
//   var isPlaying = false.obs;
//   var currentSong = Rxn<SongModel>();
//   var currentPlaybackPosition = 0.0.obs;
//   var totalDuration = 0.0.obs;
//   var playlist = <SongModel>[].obs; // List to hold the playlist
//   var currentSongIndex = 0.obs; // Index to track the current song
//   void seekToPosition(double position) {
//     _audioPlayer.seek(Duration(milliseconds: position.toInt()));
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     // Listen to playback state changes
//     _audioPlayer.playerStateStream.listen((state) {
//       isPlaying.value = state.playing;
//
//       // When song ends, play next song
//       if (state.processingState == ProcessingState.completed) {
//         playNextSong();
//       }
//     });
//
//     // Listen to position changes
//     _audioPlayer.positionStream.listen((position) {
//       currentPlaybackPosition.value = position.inMilliseconds.toDouble();
//     });
//
//     // Listen to duration changes
//     _audioPlayer.durationStream.listen((duration) {
//       if (duration != null) {
//         totalDuration.value = duration.inMilliseconds.toDouble();
//       }
//     });
//   }
//
//   void playSong(SongModel song) async {
//     currentSong.value = song;
//     currentSongIndex.value = playlist.indexOf(song); // Set current song index
//     await _audioPlayer.setFilePath(song.data);
//     _audioPlayer.play();
//   }
//
//   void togglePlayPause() {
//     if (isPlaying.value) {
//       _audioPlayer.pause();
//     } else {
//       _audioPlayer.play();
//     }
//   }
//
//   void playNextSong() {
//     // If there is a next song in the playlist, play it
//     if (currentSongIndex.value < playlist.length - 1) {
//       currentSongIndex.value++;
//       playSong(playlist[currentSongIndex.value]);
//     } else {
//       // If it's the last song, go to the first song
//       currentSongIndex.value = 0;
//       playSong(playlist[currentSongIndex.value]);
//     }
//   }
//
//   void playPreviousSong() {
//     // If there is a previous song in the playlist, play it
//     if (currentSongIndex.value > 0) {
//       currentSongIndex.value--;
//       playSong(playlist[currentSongIndex.value]);
//     } else {
//       // If it's the first song, go to the last song
//       currentSongIndex.value = playlist.length - 1;
//       playSong(playlist[currentSongIndex.value]);
//     }
//   }
//
//   // Method to add songs to the playlist
//   void addSongsToPlaylist(List<SongModel> songs) {
//     playlist.addAll(songs);
//   }
//
//   @override
//   void onClose() {
//     _audioPlayer.dispose();
//     super.onClose();
//   }
// }
//
//
//
//


import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

///new working previous play
// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:on_audio_query/on_audio_query.dart';
//
// class PlayerController extends GetxController {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//
//
//   var isPlaying = false.obs;
//   var currentSong = Rxn<SongModel>();
//   var currentPlaybackPosition = 0.0.obs;
//   var totalDuration = 0.0.obs;
//   var playlist = <SongModel>[].obs;
//   var currentSongIndex = 0.obs;
//
//   void seekToPosition(double position) {
//     _audioPlayer.seek(Duration(milliseconds: position.toInt()));
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     _audioPlayer.playerStateStream.listen((state) {
//       isPlaying.value = state.playing;
//
//       if (state.processingState == ProcessingState.completed) {
//         playNextSong();
//       }
//     });
//
//     _audioPlayer.positionStream.listen((position) {
//       currentPlaybackPosition.value = position.inMilliseconds.toDouble();
//     });
//
//     _audioPlayer.durationStream.listen((duration) {
//       if (duration != null) {
//         totalDuration.value = duration.inMilliseconds.toDouble();
//       }
//     });
//   }
//
//   void playSong(SongModel song, {bool updateIndex = true}) async {
//     // Ensure the song is in the playlist
//     if (!playlist.contains(song)) {
//       playlist.add(song);
//     }
//
//     // Update current song and index
//     currentSong.value = song;
//     if (updateIndex) {
//       currentSongIndex.value = playlist.indexOf(song);
//     }
//
//     await _audioPlayer.setFilePath(song.data);
//     _audioPlayer.play();
//   }
//
//   void togglePlayPause() {
//     if (isPlaying.value) {
//       _audioPlayer.pause();
//     } else {
//       _audioPlayer.play();
//     }
//   }
//
//   void playNextSong() {
//     if (playlist.isEmpty) return;
//
//     // Increment index, wrap around if needed
//     currentSongIndex.value = (currentSongIndex.value + 1) % playlist.length;
//     playSong(playlist[currentSongIndex.value], updateIndex: false);
//   }
//
//   void playPreviousSong() {
//     if (playlist.isEmpty) return;
//
//     // Decrement index, wrap around if needed
//     currentSongIndex.value = (currentSongIndex.value - 1 + playlist.length) % playlist.length;
//     playSong(playlist[currentSongIndex.value], updateIndex: false);
//   }
//
//   // Method to set the entire playlist at once
//   void setPlaylist(List<SongModel> songs) {
//     playlist.clear();
//     playlist.addAll(songs);
//   }
//
//   @override
//   void onClose() {
//     _audioPlayer.dispose();
//     super.onClose();
//   }
// }
///new code with working of next ,previous
// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:on_audio_query/on_audio_query.dart';
//
// class PlayerController extends GetxController {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   var repeatMode = RxInt(0); // 0: no repeat, 1: repeat one, 2: repeat all
//   var isShuffleMode = false.obs;
//
//   var isPlaying = false.obs;
//   var currentSong = Rxn<SongModel>();
//   var currentPlaybackPosition = 0.0.obs;
//   var totalDuration = 0.0.obs;
//   var playlist = <SongModel>[].obs;
//   var currentSongIndex = 0.obs;
//
//   void seekToPosition(double position) {
//     _audioPlayer.seek(Duration(milliseconds: position.toInt()));
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     _audioPlayer.playerStateStream.listen((state) {
//       isPlaying.value = state.playing;
//
//       if (state.processingState == ProcessingState.completed) {
//         playNextSong();
//       }
//     });
//
//     _audioPlayer.positionStream.listen((position) {
//       currentPlaybackPosition.value = position.inMilliseconds.toDouble();
//     });
//
//     _audioPlayer.durationStream.listen((duration) {
//       if (duration != null) {
//         totalDuration.value = duration.inMilliseconds.toDouble();
//       }
//     });
//   }
//   void toggleRepeatMode() {
//     repeatMode.value = (repeatMode.value + 1) % 3;
//   }
//
//   void toggleShuffle() {
//     isShuffleMode.toggle();
//     if (isShuffleMode.value) {
//       // Shuffle the playlist
//       playlist.shuffle();
//     } else {
//       // Restore original playlist order
//       setPlaylist(List.from(playlist));
//     }
//   }
//   void playSong(SongModel song, {List<SongModel>? allSongs}) async {
//     if (allSongs != null && playlist.isEmpty) {
//       setPlaylist(allSongs);
//     }
//
//     // Update current song and index
//     currentSong.value = song;
//     currentSongIndex.value = playlist.indexWhere((s) => s.id == song.id);
//
//     await _audioPlayer.setFilePath(song.data);
//     _audioPlayer.play();
//   }
//
//
//   void togglePlayPause() {
//     if (isPlaying.value) {
//       _audioPlayer.pause();
//     } else {
//       _audioPlayer.play();
//     }
//   }
//
//   void playNextSong() {
//     if (playlist.isEmpty) return;
//
//     currentSongIndex.value = (currentSongIndex.value + 1) % playlist.length;
//     playSong(playlist[currentSongIndex.value]);
//
//     // Increment index, wrap around if needed
//
//   }
//
//   void playPreviousSong() {
//     if (playlist.isEmpty) return;
//
//     // Decrement index, wrap around if needed
//     currentSongIndex.value = (currentSongIndex.value - 1 + playlist.length) % playlist.length;
//     playSong(playlist[currentSongIndex.value]);
//   }
//
//   // Method to set the entire playlist at once
//   void setPlaylist(List<SongModel> songs) {
//     playlist.clear();
//     playlist.addAll(songs);
//   }
//
//   @override
//   void onClose() {
//     _audioPlayer.dispose();
//     super.onClose();
//   }
// }
///exp
///
///






import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  var repeatMode = RxInt(0); // 0: no repeat, 1: repeat one, 2: repeat all
  var isShuffleMode = false.obs;

  var isPlaying = false.obs;
  var currentSong = Rxn<SongModel>();
  var currentPlaybackPosition = 0.0.obs;
  var totalDuration = 0.0.obs;
  var playlist = <SongModel>[].obs;
  var originalPlaylist = <SongModel>[];
  var currentSongIndex = 0.obs;

  void seekToPosition(double position) {
    _audioPlayer.seek(Duration(milliseconds: position.toInt()));
  }

  @override
  void onInit() {
    super.onInit();

    _audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;

      if (state.processingState == ProcessingState.completed) {
        playNextSong();
      }
    });

    _audioPlayer.positionStream.listen((position) {
      currentPlaybackPosition.value = position.inMilliseconds.toDouble();
    });

    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        totalDuration.value = duration.inMilliseconds.toDouble();
      }
    });
  }

  ///
  void _handleSongCompletion() {
    if (repeatMode.value == 1) {
      // Repeat one: Replay current song
      playSong(playlist[currentSongIndex.value]);
    } else {
      // Move to next song
      playNextSong();
    }
  }
  ///
  void toggleRepeatMode() {
    repeatMode.value = (repeatMode.value + 1) % 3;
    Get.snackbar(
      'Repeat Mode',
      repeatMode.value == 0
          ? 'Repeat Off'
          : repeatMode.value == 1
          ? 'Repeat One'
          : 'Repeat All',
    );
  }
///
  void toggleShuffle() {
    isShuffleMode.toggle();
    if (isShuffleMode.value) {
      // Store original playlist before shuffling
      originalPlaylist = List.from(playlist);
      playlist.shuffle();
    } else {
      // Restore original playlist order
      playlist.assignAll(originalPlaylist);
    }
  }

  void playSong(SongModel song, {List<SongModel>? allSongs}) async {
    if (allSongs != null && playlist.isEmpty) {
      setPlaylist(allSongs);
    }

    // Update current song and index
    currentSong.value = song;
    currentSongIndex.value = playlist.indexWhere((s) => s.id == song.id);

    await _audioPlayer.setFilePath(song.data);
    _audioPlayer.play();
  }


  void togglePlayPause() {
    if (isPlaying.value) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void playNextSong() {
    if (playlist.isEmpty) return;

    currentSongIndex.value = (currentSongIndex.value + 1) % playlist.length;
    playSong(playlist[currentSongIndex.value]);

    // Increment index, wrap around if needed

  }

  void playPreviousSong() {
    if (playlist.isEmpty) return;

    // Decrement index, wrap around if needed
    currentSongIndex.value = (currentSongIndex.value - 1 + playlist.length) % playlist.length;
    playSong(playlist[currentSongIndex.value]);
  }

  // Method to set the entire playlist at once
  void setPlaylist(List<SongModel> songs) {
    playlist.clear();
    playlist.addAll(songs);
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}



