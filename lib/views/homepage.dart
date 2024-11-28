//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:get/get.dart';
// import '../controllers/home_controller.dart';
// import '../controllers/player_controller.dart'; // New import
// import '../utils/exit_dialogue.dart';
// import '../widgets/song_card.dart';
// import '../widgets/mini_player.dart'; // New import
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final MusicController musicController = Get.put(MusicController());
//     final PlayerController playerController = Get.put(PlayerController());
//     return WillPopScope(
//       onWillPop: () => showExitDialog(context),
//
//
//       child:  Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         toolbarHeight: 70,
//         title: Text(
//           "Music Player",
//           style: GoogleFonts.jost(
//             fontWeight: FontWeight.bold,
//             fontSize: 30,
//           ),
//         ),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(30),
//               bottomRight: Radius.circular(30),
//             ),
//             gradient: LinearGradient(
//               colors: [Colors.blueGrey, Colors.blueGrey],
//               begin: Alignment.bottomCenter,
//               end: Alignment.topCenter,
//             ),
//           ),
//         ),
//
//         systemOverlayStyle: SystemUiOverlayStyle.light,
//       ),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Align(
//                 alignment: Alignment.center,
//                 child: Text(
//                   "ALL TRACKS",
//                   style: GoogleFonts.jost(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 24.0,
//                   ),
//                 ),
//               ),
//               Obx(() {
//                 if (musicController.isLoading.value) {
//                   return Expanded(
//                     child: Center(child: CircularProgressIndicator()),
//                   );
//                 } else if (musicController.songs.isEmpty) {
//                   return Expanded(
//                     child: Center(
//                       child: Text(
//                         "Ooops No songs found!!!",
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   );
//                 } else {
//                   return Expanded(
//                     child: ListView.builder(
//                       itemCount: musicController.songs.length,
//                       itemBuilder: (context, index) {
//                         final song = musicController.songs[index];
//                         return GestureDetector(
//                           onTap: () {
//                             // Play the selected song
//                             playerController.playSong(song);
//                           },
//                           child: SongCard(song: song),
//                         );
//                       },
//                     ),
//                   );
//                 }
//               }),
//             ],
//           ),
//
//           // MiniPlayer
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Obx(() {
//               final currentSong = playerController.currentSong.value;
//               return currentSong != null
//                   ? MiniPlayer(song: currentSong)
//                   : SizedBox.shrink();
//             }),
//           ),
//         ],
//       ),
//       backgroundColor: Colors.blue,
//     ),);
//   }
//
// }
//
//
//
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/player_controller.dart';
import '../main_layout.dart';
import '../widgets/song_card.dart';
import '../utils/exit_dialogue.dart';

class HomePage extends StatelessWidget {
  final MusicController musicController = Get.put(MusicController());
  final PlayerController playerController = Get.put(PlayerController());


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitDialog(context),
      child: MainLayout(
        bodyContent: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "ALL TRACKS",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
            Obx(() {
              if (musicController.isLoading.value) {
                return Expanded(child: Center(child: CircularProgressIndicator()));
              } else if (musicController.songs.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      "Ooops No songs found!!!",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: musicController.songs.length,
                    itemBuilder: (context, index) {
                      final song = musicController.songs[index];
                      return GestureDetector(
                        onTap: () {
                          ///
                          //player is commented because play,previous working
                          // playerController.playSong(song);
                          playerController.playSong(song, allSongs: musicController.songs);
                        },
                        child: SongCard(song: song),
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
