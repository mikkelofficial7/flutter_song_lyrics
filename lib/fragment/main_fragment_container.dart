import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter/bloc/api_bloc.dart';
import 'package:sample_flutter/bloc/api_event.dart';
import 'package:sample_flutter/bloc/api_state.dart';
import 'package:sample_flutter/constants/colorconstant.dart';
import 'package:sample_flutter/fragment/detail_fragment.dart';
import 'package:sample_flutter/model/model_song.dart';

class MainFragmentContainer extends StatefulWidget {
  const MainFragmentContainer({super.key});

  @override
  _MainFragmentContainerState createState() => _MainFragmentContainerState();
}

class _MainFragmentContainerState extends State<MainFragmentContainer> {
  final ApiBloc _apiBloc = ApiBloc();

  @override
  void initState() {
    _apiBloc.add(GetSongList());
    super.initState();
  }

  ItemSongModel? selectedSong;
  int selectedPosition = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (_) => _apiBloc,
        child: BlocListener<ApiBloc, ApiState>(
          listener: (context, state) {
            if (state is SongError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<ApiBloc, ApiState>(
            builder: (context, state) {
              if (state is SongInitial) {
                return _buildLoading();
              } else if (state is SongLoading) {
                return _buildLoading();
              } else if (state is SongLoaded) {
                return _buildListSong(context, state.songModel);
              } else if (state is SongError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  String showSelectedSong() {
    String? songName = selectedSong?.song_name;

    if(songName?.isEmpty == true || songName == null) {
      return "You choose nothing";
    } else {
      return "You choose: $songName";
    }
  }

  List<Flexible> showViewSeeDetailSong() {
    String? songName = selectedSong?.song_name;

    List<Flexible> viewList = <Flexible>[];

    viewList.add(
        Flexible(flex: 2, child: Center(
          child: Text(
            showSelectedSong(),
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
                navigateToDetailPage(selectedSong);
              },
              child: const Text("See Detail", textAlign: TextAlign.center,)
        ))
      );
    }

    return viewList;
  }

  void navigateToDetailPage(ItemSongModel? selectedSong) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailFragment(selectedSong),));
  }

  Widget _buildListSong(BuildContext context, SongModel listSong) {
    return Column(
      children: [
        Flexible(
          flex: 0,
          child: Container(
            padding: EdgeInsets.all(10),
            color: ColorConstant.primaryColor,
            height: 100,
            child: Column(
              children: showViewSeeDetailSong(),
            ),
          ),
        ),
        Flexible(flex: 1, child: Container(
          child: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: listSong.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(listSong.data[index].image_url),
                ),
                tileColor: selectedPosition == index ? ColorConstant.blue : null,
                title: Text(listSong.data[index].song_name),
                subtitle: Text(listSong.data[index].song_by),
                onTap: () {
                  setState(() {
                    selectedSong = listSong.data[index];
                    selectedPosition = index;
                  });
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        ),)
      ],
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}