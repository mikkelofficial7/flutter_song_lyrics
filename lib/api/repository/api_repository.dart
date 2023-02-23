import 'package:sample_flutter/api/provider/api_provider.dart';
import 'package:sample_flutter/model/model_song.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<SongModel> fetchListSong() {
    return _provider.getListSong();
  }
}

class NetworkError extends Error {}