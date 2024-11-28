import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/playlist_contoller.dart';
import '../models/playlist_model.dart';

class PlaylistDetailsView extends StatelessWidget {
  final PlaylistController playlistController =
      Get.put(PlaylistController());
  final playlist = Get.arguments as Playlist?;// Initialize controller

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = Get.arguments;

    if (arguments == null) {
      print('ERROR: No arguments passed to PlaylistDetailsView');
      return Scaffold(
        appBar: AppBar(title: Text('Playlist Error')),
        body: Center(
          child: Text('No playlist selected'),
        ),
      );
    }

    if (arguments is! Playlist) {
      print('ERROR: Invalid argument type passed: ${arguments.runtimeType}');
      return Scaffold(
        appBar: AppBar(title: Text('Playlist Error')),
        body: Center(
          child: Text('Invalid playlist data'),
        ),
      );
    }

    final Playlist playlist = arguments;
   /// final playlist = Get.arguments as Playlist; // Retrieve playlist

    return Scaffold(
      appBar: AppBar(
        title: Text(
          playlist.name,
          style: GoogleFonts.jost(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: playlist.songs.isEmpty
          ? Center(
              child: Text(
                'No songs in this playlist',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: playlist.songs.length,
              itemBuilder: (context, index) {
                final song = playlist.songs[index];

                return ListTile(
                  leading: QueryArtworkWidget(
                    id: song.id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: Image.asset(
                      'assets/images/music_back.jpg',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  title: Text(song.title),
                  subtitle: Text(song.artist ?? 'Unknown Artist'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Wrap this action inside Obx if the playlist changes reactively
                      playlistController.removeSongFromPlaylist(playlist, song);
                    },
                  ),
                );
              },
            ),
    );
  }
}





