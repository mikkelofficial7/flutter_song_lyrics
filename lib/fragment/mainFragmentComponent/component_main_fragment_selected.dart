import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/colorconstant.dart';
import '../../model/model_song.dart';
import '../../route/route.dart';

class ComponentMainFragmentSelected {
  List<Flexible> showButtonSeeDetailSong(BuildContext context, ItemSongModel? selectedSong) {
    String? songName = selectedSong?.song_name;

    List<Flexible> viewList = <Flexible>[];

    viewList.add(
        Flexible(flex: 2, child: Center(
          child: Text(
            _showSelectedSong(selectedSong),
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

  String _showSelectedSong(ItemSongModel? selectedSong) {
      String? songName = selectedSong?.song_name;

      if(songName?.isEmpty == true || songName == null) {
        return "You didn't choose any song yet";
      } else {
        return "You choose: $songName song";
      }
  }
}