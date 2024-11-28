class MusicModel {
  String? id;
  String? path;
  String? title;
  String? artist;

  MusicModel({this.id, this.path, this.title, this.artist});

  // Convert MusicModel to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'path': path,
      'title': title,
      'artist': artist,
    };
  }

  // Create MusicModel from JSON (database map)
  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      id: json['id'],
      path: json['path'],
      title: json['title'],
      artist: json['artist'],
    );
  }
}
