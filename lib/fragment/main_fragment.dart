import 'package:flutter/material.dart';
import 'package:sample_flutter/constants/colorconstant.dart';
import 'package:sample_flutter/fragment/main_fragment_container.dart';
import 'package:sample_flutter/model/model_song.dart';
import 'package:sample_flutter/network/network.dart';
import '../appbar.dart';

class MainFragment extends StatelessWidget {
  final Future<SongModel> _fetchDataSong = NetworkRequest().getListSong();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar("List of Hits Song", ColorConstant.blue),
      body: MainFragmentContainer(_fetchDataSong)
    );
  }
}