import 'package:http/http.dart' as http;
import 'package:sample_flutter/model/model_song.dart';
import 'dart:convert';
import '../constants/pathconstant.dart';

class NetworkRequest {
  final String apiUrl = PathConstant.baseUrl;

  Future<SongModel> getListSong() async {
    var result = await http.get("$apiUrl${PathConstant.listSong}");
    return SongModel.fromJson(json.decode(result.body));
  }
}