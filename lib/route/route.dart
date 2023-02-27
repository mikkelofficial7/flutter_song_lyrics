
import 'package:flutter/material.dart';
import '../fragment/detail_fragment.dart';
import '../model/model_song.dart';

void navigateToDetailPage(BuildContext context, ItemSongModel? selectedSong) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailFragment(selectedSong),));
}