import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/colorconstant.dart';
import '../../model/model_song.dart';
import '../detail_fragment.dart';

List<Flexible> showViewSeeDetailSong(BuildContext context, ItemSongModel? selectedSong) {
  String? songName = selectedSong?.song_name;

  List<Flexible> viewList = <Flexible>[];

  viewList.add(
      Flexible(flex: 2, child: Center(
        child: Text(
          showSelectedSong(selectedSong),
          textAlign: TextAlign.center,
        ),
      ))
  );

  if(songName?.isEmpty == false && songName != null) {
    viewList.add(
        Flexible(
            flex: 1,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: ColorConstant.blue),
                onPressed: () {
                  navigateToDetailPage(context, selectedSong);
                },
                child: const Text("See Detail", textAlign: TextAlign.center,)
            ))
    );
  }

  return viewList;
}

String showSelectedSong(ItemSongModel? selectedSong) {
  String? songName = selectedSong?.song_name;

  if(songName?.isEmpty == true || songName == null) {
    return "You choose nothing";
  } else {
    return "You choose: $songName";
  }
}

void navigateToDetailPage(BuildContext context, ItemSongModel? selectedSong) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailFragment(selectedSong),));
}