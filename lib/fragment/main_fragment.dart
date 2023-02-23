import 'package:flutter/material.dart';
import 'package:sample_flutter/api/repository/api_repository.dart';
import 'package:sample_flutter/constants/colorconstant.dart';
import 'package:sample_flutter/fragment/main_fragment_container.dart';
import 'package:sample_flutter/model/model_song.dart';
import '../appbar.dart';

class MainFragment extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar("List of Hits Song", ColorConstant.blue),
      body: MainFragmentContainer()
    );
  }
}