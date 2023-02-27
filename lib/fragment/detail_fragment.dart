import 'package:flutter/material.dart';
import 'package:sample_flutter/constants/colorconstant.dart';
import 'package:sample_flutter/model/model_song.dart';
import 'package:sample_flutter/styles/sizing.dart';
import 'package:sample_flutter/styles/styling.dart';
import '../appbar.dart';

class DetailFragment extends StatelessWidget {
  final ItemSongModel? songData;

  const DetailFragment(this.songData);

  @override
  Widget build(BuildContext context) {
    String songName = songData?.song_name ?? "";

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Appbar("$songName: Lyrics", ColorConstant.transparent),
      body: Column(
        children: [
          Flexible(
              child: Container(
                decoration: BoxDecoration(
                    gradient:  Styling().gradientBackground(ColorConstant.black, ColorConstant.black87)
                ),
                height: double.maxFinite,
                child: Stack(
                  children: [
                    Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Container(
                          height: WidgetSize.imageBannerHeight,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: ColorConstant.black
                          ),
                          child: Image(
                            image: NetworkImage(songData!.image_url.toString()),
                          ),
                        ),
                        Positioned(
                            bottom: 30,
                            left: 10,
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  color: ColorConstant.secondaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(songName, style: Styling().titleTextStyle(),),
                                  Text("by ${songData!.song_by}", textAlign: TextAlign.start, style: Styling().titleTextStyleSmall(),)
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                    Positioned(
                        top: WidgetSize.imageBannerHeight - 20,
                        left: 10,
                        right: 10,
                        bottom: 10,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                              color: ColorConstant.blueGrey80,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                                bottomLeft: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0),
                              )
                          ),
                          child: SingleChildScrollView(
                              child: Text(songData!.lyrics.toString(), style: Styling().contentTextStyle(),)
                          ),
                        )
                    ),
                    Positioned(
                        top: WidgetSize.imageBannerHeight - 50,
                        right: 30,
                        child: CircleAvatar(
                          radius: 30,
                          child: Image.asset("assets/images/music.png"),
                        )
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}