import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/playlist_contoller.dart';
import '../main_layout.dart';
import '../models/playlist_model.dart';
import '../utils/exit_dialogue.dart';
import 'playlistdetail.dart';

class PlayList extends StatelessWidget {
  final PlaylistController playlistController = Get.put(PlaylistController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitDialog(context),
      child: MainLayout(
        bodyContent: Stack(
          children: [
            Obx(() {
              return playlistController.playlists.isEmpty
                  ? Center(
                child: Text(
                  'No playlists created',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              )
                  : ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: playlistController.playlists.length,
                itemBuilder: (context, index) {
                  final playlist = playlistController.playlists[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      title: Text(
                        playlist.name,
                        style: GoogleFonts.jost(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Text('${playlist.songs.length} songs'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _confirmDeletePlaylist(playlist),
                          ),
                          IconButton(
                            icon: Icon(Icons.visibility, color: Colors.blue),
                            onPressed: () => _viewPlaylistDetails(playlist),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),

            // Floating Action Button positioned above the mini player
            Positioned(
              bottom: 120,  // Adjust based on mini player height
              right: 20,
              child: FloatingActionButton(
                onPressed: _showCreatePlaylistDialog,
                child: Icon(Icons.add, size: 30),
                backgroundColor: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreatePlaylistDialog() {
    final TextEditingController nameController = TextEditingController();
    Get.defaultDialog(
      title: 'Create New Playlist',
      content: TextField(
        controller: nameController,
        decoration: InputDecoration(
          hintText: 'Enter playlist name',
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          if (nameController.text.isNotEmpty) {
            playlistController.createPlaylist(nameController.text);
            Get.back();
          }
        },
        child: Text('Create'),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text('Cancel'),
      ),
    );
  }

  void _confirmDeletePlaylist(Playlist playlist) {
    Get.defaultDialog(
      title: 'Delete Playlist',
      middleText: 'Are you sure you want to delete "${playlist.name}"?',
      confirm: ElevatedButton(
        onPressed: () {
          playlistController.deletePlaylist(playlist);
          Get.back();
        },
        child: Text('Yes'),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text('No'),
      ),
    );
  }

  void _viewPlaylistDetails(Playlist playlist) {
    Get.to(() => PlaylistDetailsView(), arguments: playlist);
  }
}
