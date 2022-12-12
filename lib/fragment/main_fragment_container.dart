import 'package:flutter/material.dart';
import 'package:sample_flutter/constants/colorconstant.dart';
import 'package:sample_flutter/fragment/detail_fragment.dart';
import 'package:sample_flutter/model/model_song.dart';

class MainFragmentContainer extends StatefulWidget {
  final Future<SongModel> dataSong;
  const MainFragmentContainer(this.dataSong, {super.key});

  @override
  _MainFragmentContainerState createState() => _MainFragmentContainerState(dataSong);
}

class _MainFragmentContainerState extends State<MainFragmentContainer> {
  final Future<SongModel> dataSong;

  ItemSongModel? selectedSong;
  int selectedPosition = -1;

  _MainFragmentContainerState(this.dataSong);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
          Flexible(flex: 1, child: FutureBuilder<SongModel>(
            future: dataSong,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ItemSongModel> listSong = snapshot.data!.data;

                return ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(listSong[index].image_url),
                        ),
                        tileColor: selectedPosition == index ? ColorConstant.blue : null,
                        title: Text(listSong[index].song_name),
                        subtitle: Text(listSong[index].song_by),
                        onTap: () {
                          setState(() {
                            selectedSong = listSong[index];
                            selectedPosition = index;
                          });
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),)
        ],
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
              child: Text("See Detail", textAlign: TextAlign.center,)
        ))
      );
    }

    return viewList;
  }

  void navigateToDetailPage(ItemSongModel? selectedSong) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailFragment(selectedSong),));
  }
}