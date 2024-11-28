//
// import 'package:audio_service/audio_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import '../controllers/player_controller.dart';
// import '../views/play_screen.dart';
//
// class MiniPlayer extends StatelessWidget {
//   final SongModel song;
//
//   const MiniPlayer({Key? key, required this.song}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final PlayerController playerController = Get.find();
//
//     return GestureDetector(
//       onTap: () {
//         // Navigate to full player screen
//         Get.to(() => PlayScreen(song: song));
//       },
//       child: Column(
//         children: [
//           // Progress Indicator (remains the same as previous implementation)
//           Obx(() {
//             final current = playerController.currentPlaybackPosition.value;
//             final total = playerController.totalDuration.value;
//             final progress = total > 0 ? current / total : 0.0;
//
//             return LinearProgressIndicator(
//               value: progress,
//               backgroundColor: Colors.blueGrey.shade600,
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//               minHeight: 2,
//             );
//           }),
//
//           // MiniPlayer UI
//           Container(
//             height: 70,
//             margin: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.blueGrey.shade700,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.3),
//                   blurRadius: 5,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 // Artwork
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: QueryArtworkWidget(
//                     id: song.id,
//                     type: ArtworkType.AUDIO,
//                     nullArtworkWidget: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.blueGrey.shade600,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Icon(Icons.music_note, color: Colors.white),
//                     ),
//                   ),
//                 ),
//
//                 // Song Info
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         song.title,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         song.artist ?? 'Unknown Artist',
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(color: Colors.white70, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // Controls
//                 IconButton(
//                   icon: const Icon(Icons.skip_previous, color: Colors.white),
//                   onPressed: () {
//                     AudioService.skipToPrevious(); // Skip to previous song
//                   },
//                 ),
//
//                 Obx(() {
//                   return IconButton(
//                     icon: Icon(
//                       playerController.isPlaying.value ? Icons.pause : Icons.play_arrow,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       playerController.togglePlayPause();
//                       if (playerController.isPlaying.value) {
//                         AudioService.play();
//                       } else {
//                         AudioService.pause();
//                       }
//                     },
//                   );
//                 }),
//
//                 IconButton(
//                   icon: const Icon(Icons.skip_next, color: Colors.white),
//                   onPressed: () {
//                     AudioService.skipToNext(); // Skip to next song
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:on_audio_query/on_audio_query.dart';
//
// import '../controllers/player_controller.dart';
// import '../views/play_screen.dart';
//
// class MiniPlayer extends StatelessWidget {
//   final SongModel song;
//
//   const MiniPlayer({Key? key, required this.song}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final PlayerController playerController = Get.find();
//
//     return GestureDetector(
//       onTap: () {
//         // Navigate to full player screen
//         Get.to(() => PlayScreen(song: song));
//       },
//       child: Column(
//         children: [
//           // Progress Indicator
//           Obx(() {
//             final current = playerController.currentPlaybackPosition.value;
//             final total = playerController.totalDuration.value;
//             final progress = total > 0 ? current / total : 0.0;
//
//             return LinearProgressIndicator(
//               value: progress,
//               backgroundColor: Colors.blueGrey.shade600,
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//               minHeight: 2,
//             );
//           }),
//
//           // MiniPlayer UI
//           Container(
//             height: 70,
//             margin: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.blueGrey.shade700,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.3),
//                   blurRadius: 5,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 // Artwork
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: QueryArtworkWidget(
//                     id: song.id,
//                     type: ArtworkType.AUDIO,
//                     nullArtworkWidget: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.blueGrey.shade600,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Icon(Icons.music_note, color: Colors.white),
//                     ),
//                   ),
//                 ),
//
//                 // Song Info
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         song.title,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         song.artist ?? 'Unknown Artist',
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(color: Colors.white70, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // Controls
//                 IconButton(
//                   icon: const Icon(Icons.skip_previous, color: Colors.white),
//                   onPressed: () {
//                     playerController.playPreviousSong(); // Skip to previous song
//                   },
//                 ),
//
//                 Obx(() {
//                   return IconButton(
//                     icon: Icon(
//                       playerController.isPlaying.value ? Icons.pause : Icons.play_arrow,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       playerController.togglePlayPause();
//                     },
//                   );
//                 }),
//
//                 IconButton(
//                   icon: const Icon(Icons.skip_next, color: Colors.white),
//                   onPressed: () {
//                     playerController.playNextSong(); // Skip to next song
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

///exp



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controllers/player_controller.dart';
import '../views/play_screen.dart';

class MiniPlayer extends StatelessWidget {
  final SongModel song;

  const MiniPlayer({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.find();

    return GestureDetector(
      onTap: () {
        // Navigate to full player screen
        Get.to(() => PlayScreen(song: song));
      },
      child: Column(
        children: [
          // Progress Indicator
          Obx(() {
            final current = playerController.currentPlaybackPosition.value;
            final total = playerController.totalDuration.value;
            final progress = total > 0 ? current / total : 0.0;

            return LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.blueGrey.shade600,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 2,
            );
          }),

          // MiniPlayer UI
          Container(
            height: 70,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade700,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                // Artwork
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: QueryArtworkWidget(
                    id: song.id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade600,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.music_note, color: Colors.white),
                    ),
                  ),
                ),

                // Song Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        song.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        song.artist ?? 'Unknown Artist',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),

                // Controls
                IconButton(
                  icon: const Icon(Icons.skip_previous, color: Colors.white),
                  onPressed: () {
                    playerController.playPreviousSong(); // Skip to previous song
                  },
                ),

                Obx(() {
                  return IconButton(
                    icon: Icon(
                      playerController.isPlaying.value ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      playerController.togglePlayPause();
                    },
                  );
                }),

                IconButton(
                  icon: const Icon(Icons.skip_next, color: Colors.white),
                  onPressed: () {
                    playerController.playNextSong(); // Skip to next song
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

