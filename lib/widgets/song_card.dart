//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import '../controllers/favourite_controller.dart';
// import '../controllers/playlist_contoller.dart';
//
// class SongCard extends StatelessWidget {
//   final SongModel song;
//
//   final FavoriteController favoriteController = Get.find<FavoriteController>();
//
//   SongCard({Key? key, required this.song}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       child: ListTile(
//         contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//         leading: ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: QueryArtworkWidget(
//             id: song.id,
//             type: ArtworkType.AUDIO,
//             artworkHeight: 50,
//             artworkWidth: 50,
//             nullArtworkWidget: Image.asset(
//               'assets/images/music_back.jpg',
//               height: 50,
//               width: 50,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         title: Text(
//           song.title,
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(
//           song.artist ?? "Unknown Artist",
//           style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//         ),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Heart icon for liking/unliking songs
//             Obx(() {
//               bool isLiked = favoriteController.isFavorite(song);
//               return IconButton(
//                 icon: Icon(
//                   isLiked ? Icons.favorite : Icons.favorite_border,
//                   color: isLiked ? Colors.red : Colors.grey,
//                 ),
//                 onPressed: () {
//                   favoriteController.toggleFavorite(song);
//                 },
//               );
//             }),
//             // More options menu
//             PopupMenuButton<String>(
//               icon: Icon(Icons.more_vert),
//               onSelected: (value) {
//                 if (value == 'playlist') {
//                   _showAddToPlaylistDialog(context);
//                 } else if (value == 'delete') {
//                   _confirmDelete(context);
//                 }
//               },
//               itemBuilder: (BuildContext context) {
//                 return [
//                   PopupMenuItem(
//                       value: 'playlist', child: Text('Add to Playlist')),
//                   PopupMenuItem(value: 'delete', child: Text('Delete')),
//                 ];
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showAddToPlaylistDialog(BuildContext context) {
//     final PlaylistController playlistController =
//         Get.find<PlaylistController>();
//     final TextEditingController nameController =
//         TextEditingController(); // Controller for playlist name input
//
//     Get.defaultDialog(
//       title: 'Add to Playlist',
//       content: Obx(() {
//         if (playlistController.playlists.isEmpty) {
//           // If no playlists exist, prompt to create one
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('No playlists available. Create one first.'),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   _showCreatePlaylistDialog(); // Function to handle playlist creation
//                 },
//                 child: Text('Create Playlist'),
//               ),
//             ],
//           );
//         } else {
//           // Display the list of available playlists
//           return Container(
//             width: double.maxFinite,
//             height: 200,
//             child: ListView.builder(
//               itemCount: playlistController.playlists.length,
//               itemBuilder: (context, index) {
//                 final playlist = playlistController.playlists[index];
//                 return ListTile(
//                   title: Text(playlist.name),
//                   onTap: () {
//                     playlistController.addSongToPlaylist(playlist, song);
//                     Get.back(); // Close the dialog
//                   },
//                 );
//               },
//             ),
//           );
//         }
//       }),
//       confirm: SizedBox.shrink(), // Remove default confirm button
//       cancel: ElevatedButton(
//         onPressed: () => Get.back(),
//         child: Text('Cancel'),
//       ),
//     );
//   }
//
// // Function to handle creating a new playlist
//   void _showCreatePlaylistDialog() {
//     final TextEditingController nameController = TextEditingController();
//     final PlaylistController playlistController =
//         Get.find<PlaylistController>();
//
//     Get.defaultDialog(
//       title: 'Create New Playlist',
//       content: TextField(
//         controller: nameController,
//         decoration: InputDecoration(hintText: 'Enter playlist name'),
//       ),
//       confirm: ElevatedButton(
//         onPressed: () {
//           if (nameController.text.isNotEmpty) {
//             playlistController.createPlaylist(nameController.text.trim());
//             Get.back(); // Close the create playlist dialog
//           }
//         },
//         child: Text('Create'),
//       ),
//       cancel: ElevatedButton(
//         onPressed: () => Get.back(),
//         child: Text('Cancel'),
//       ),
//     );
//   }
//
//   void _confirmDelete(BuildContext context) {
//     Get.defaultDialog(
//       title: 'Delete Song',
//       middleText: 'Are you sure you want to delete this song?',
//       confirm: ElevatedButton(
//         onPressed: () {
//           // Add your deletion logic here
//           Get.back();
//         },
//         child: Text('Yes'),
//       ),
//       cancel: ElevatedButton(
//         onPressed: () => Get.back(),
//         child: Text('No'),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/favourite_controller.dart';
import '../controllers/playlist_contoller.dart';

class SongCard extends StatelessWidget {
  final SongModel song;

  final FavoriteController favoriteController = Get.find<FavoriteController>();

  SongCard({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: QueryArtworkWidget(
            id: song.id,
            type: ArtworkType.AUDIO,
            artworkHeight: 50,
            artworkWidth: 50,
            nullArtworkWidget: Image.asset(
              'assets/images/music_back.jpg',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          song.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          song.artist ?? "Unknown Artist",
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Heart icon for liking/unliking songs
            Obx(() {
              bool isLiked = favoriteController.isFavorite(song);
              return IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  favoriteController.toggleFavorite(song);
                },
              );
            }),
            // More options menu
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'playlist') {
                  _showAddToPlaylistDialog(context);
                } else if (value == 'delete') {
                  _confirmDelete(context);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                      value: 'playlist', child: Text('Add to Playlist')),
                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddToPlaylistDialog(BuildContext context) {
    final PlaylistController playlistController = Get.find<PlaylistController>();

    Get.defaultDialog(
      title: 'Add to Playlist',
      content: Obx(() {
        if (playlistController.playlists.isEmpty) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('No playlists available. Create one first.'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _showCreatePlaylistDialog(); // Function to handle playlist creation
                },
                child: Text('Create Playlist'),
              ),
            ],
          );
        } else {
          return Container(
            width: double.maxFinite,
            height: 200,
            child: ListView.builder(
              itemCount: playlistController.playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlistController.playlists[index];
                return ListTile(
                  title: Text(playlist.name),
                  onTap: () {
                    playlistController.addSongToPlaylist(playlist, song); // This should work now
                    Get.back(); // Close the dialog
                  },
                );
              },
            ),
          );
        }
      }),
      confirm: SizedBox.shrink(), // Remove default confirm button
      cancel: ElevatedButton(
        onPressed: () => Get.back(),
        child: Text('Cancel'),
      ),
    );
  }



// Function to handle creating a new playlist
  void _showCreatePlaylistDialog() {
    final TextEditingController nameController = TextEditingController();
    final PlaylistController playlistController =
    Get.find<PlaylistController>();

    Get.defaultDialog(
      title: 'Create New Playlist',
      content: TextField(
        controller: nameController,
        decoration: InputDecoration(hintText: 'Enter playlist name'),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          if (nameController.text.isNotEmpty) {
            playlistController.createPlaylist(nameController.text.trim());
            Get.back(); // Close the create playlist dialog
          }
        },
        child: Text('Create'),
      ),
      cancel: ElevatedButton(
        onPressed: () => Get.back(),
        child: Text('Cancel'),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    Get.defaultDialog(
      title: 'Delete Song',
      middleText: 'Are you sure you want to delete this song?',
      confirm: ElevatedButton(
        onPressed: () {
          // Add your deletion logic here
          Get.back();
        },
        child: Text('Yes'),
      ),
      cancel: ElevatedButton(
        onPressed: () => Get.back(),
        child: Text('No'),
      ),
    );
  }
}
