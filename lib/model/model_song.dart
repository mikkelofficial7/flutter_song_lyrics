// Reference from:
// https://levelup.gitconnected.com/flutter-app-from-scratch-part-2-define-models-and-set-up-database-78a67666527a

class SongModel {
  final bool status;
  final List<ItemSongModel> data;

  const SongModel({required this.status, required this.data });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      status: json['status'],
      data: json.containsKey("data") ? List<ItemSongModel>.from(json["data"].map((x) => ItemSongModel.fromJson(x))) : <ItemSongModel>[]
    );
  }
}

class ItemSongModel {
  final String? song_name;
  final String? years;
  final String? song_by;
  final String? image_url;
  final String? lyrics;

  ItemSongModel({this.song_name, this.years, this.song_by, this.image_url, this.lyrics});

  factory ItemSongModel.fromJson(Map<String, dynamic> json) {
    return ItemSongModel(
        song_name: json['song_name'],
        years: json['years'],
        song_by: json['song_by'],
        image_url: json['image_url'],
        lyrics: json['lyrics'],
    );
  }
}