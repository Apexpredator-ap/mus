import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Playlist {
  int? id;
  String name;
  List<SongModel> songs;

  Playlist({
    this.id,
    required this.name,
    this.songs = const []
    // required this.songs,
  });

  // Convert a Playlist object into a Map for SQL storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Create a Playlist object from a Map
  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      id: map['id'],
      name: map['name'],
      songs: [], // You can later fetch songs for the playlist from the database
    );
  }
}



