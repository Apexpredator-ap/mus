// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import '../controllers/favourite_controller.dart';
// import '../utils/exit_dialogue.dart';
// import '../widgets/song_card.dart';
//
// class LibraryPage extends StatelessWidget {
//   final FavoriteController favoriteController = Get.put(FavoriteController());
//   // final FavoriteController favoriteController = Get.find(); // Access the existing controller
//
//   LibraryPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () => showExitDialog(context),
//     child: Scaffold(
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
//         systemOverlayStyle: SystemUiOverlayStyle.light,
//       ),
//       backgroundColor: Colors.blue,
//       body: Obx(() {
//         if (favoriteController.favoriteSongs.isEmpty) {
//           return Center(
//             child: Text(
//               "No liked songs yet!",
//               style: GoogleFonts.amaranth(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 24.0,
//               ),
//             ),
//           );
//         } else {
//           return ListView.builder(
//             itemCount: favoriteController.favoriteSongs.length,
//             itemBuilder: (context, index) {
//               final SongModel song = favoriteController.favoriteSongs[index]; // Explicitly typed
//               return SongCard(song: song);
//             },
//           );
//         }
//       }),)
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favourite_controller.dart';
import '../main_layout.dart';
import '../widgets/song_card.dart';
import '../utils/exit_dialogue.dart';

class LibraryPage extends StatelessWidget {
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitDialog(context),
      child: MainLayout(
        bodyContent: Obx(() {
          if (favoriteController.favoriteSongs.isEmpty) {
            return Center(
              child: Text(
                "No liked songs yet!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: favoriteController.favoriteSongs.length,
              itemBuilder: (context, index) {
                final song = favoriteController.favoriteSongs[index];
                return SongCard(song: song);
              },
            );
          }
        }),
      ),
    );
  }
}
