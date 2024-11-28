// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:on_audio_query/on_audio_query.dart';
//
// import '../controllers/home_controller.dart';
// import '../controllers/player_controller.dart';
// import '../main_layout.dart';
// import '../utils/exit_dialogue.dart';
// import '../widgets/song_card.dart';
//
// class SearchPage extends StatefulWidget {
//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage> {
//   final TextEditingController _searchController = TextEditingController();
//   final MusicController _musicController = Get.find();
//   final PlayerController _playerController = Get.find();
//
//   List<SongModel> _filteredSongs = [];
//
//   void _filterSongs(String query) {
//     setState(() {
//       _filteredSongs = _musicController.songs.where((song) {
//         return song.title.toLowerCase().startsWith(query.toLowerCase());
//       }).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () => showExitDialog(context),
//
//    child:  MainLayout(
//       bodyContent: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 controller: _searchController,
//                 onChanged: _filterSongs,
//                 decoration: InputDecoration(
//                   hintText: 'Search...',
//                   hintStyle: GoogleFonts.amaranth(
//                       textStyle: TextStyle(color: Colors.grey)),
//                   prefixIcon: Icon(Icons.search, color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.grey[900],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),v
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             Expanded(
//               child: Obx(() {
//                 // Check if songs are still loading
//                 if (_musicController.isLoading.value) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//
//                 // If no search query, show initial state
//                 if (_searchController.text.isEmpty) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: 80,
//                           height: 80,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(color: Colors.grey, width: 2),
//                           ),
//                           child: Icon(
//                             Icons.language,
//                             size: 50,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         Text(
//                           'Search to get results',
//                           style: GoogleFonts.amaranth(
//                             textStyle: TextStyle(
//                                 fontSize: 22, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//
//                 // If filtered songs list is empty
//                 if (_filteredSongs.isEmpty) {
//                   return Center(
//                     child: Text(
//                       'No songs found',
//                       style: GoogleFonts.amaranth(
//                         textStyle: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                     ),
//                   );
//                 }
//
//                 // Display filtered songs
//                 return ListView.builder(
//                   itemCount: _filteredSongs.length,
//                   itemBuilder: (context, index) {
//                     final song = _filteredSongs[index];
//                     return GestureDetector(
//                       onTap: () {
//                         // Play the selected song
//                         _playerController.playSong(song);
//                       },
//                       child: SongCard(song: song),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),)
//     );
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controllers/home_controller.dart';
import '../controllers/player_controller.dart';
import '../main_layout.dart';
import '../utils/exit_dialogue.dart';
import '../widgets/song_card.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final MusicController _musicController = Get.find();
  final PlayerController _playerController = Get.find();

  List<SongModel> _filteredSongs = [];

  void _filterSongs(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSongs = [];
      } else {
        _filteredSongs = _musicController.songs.where((song) {
          return song.title.toLowerCase().startsWith(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear(); // Clear the text in the controller
    _filterSongs(''); // Reset the filtered song list
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitDialog(context),
      child: MainLayout(
        bodyContent: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterSongs,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: GoogleFonts.amaranth(
                      textStyle: TextStyle(color: Colors.grey),
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.grey),
                      onPressed: _clearSearch,
                    )
                        : null,
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (_musicController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (_searchController.text.isEmpty) {
                    return _buildInitialState();
                  }

                  if (_filteredSongs.isEmpty) {
                    return _buildNoResultsState();
                  }

                  return ListView.builder(
                    itemCount: _filteredSongs.length,
                    itemBuilder: (context, index) {
                      final song = _filteredSongs[index];
                      return GestureDetector(
                        onTap: () {
                          _playerController.playSong(song);
                        },
                        child: SongCard(song: song),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 2),
            ),
            child: Icon(
              Icons.language,
              size: 50,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Search to get results',
            style: GoogleFonts.amaranth(
              textStyle:
              TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Text(
        'No songs found',
        style: GoogleFonts.amaranth(
          textStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}