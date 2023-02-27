import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter/bloc/api/api_bloc.dart';
import 'package:sample_flutter/bloc/api/api_event.dart';
import 'package:sample_flutter/bloc/api/api_state.dart';
import 'package:sample_flutter/bloc/item_select/itemselect_state.dart';
import 'package:sample_flutter/constants/colorconstant.dart';
import 'package:sample_flutter/model/model_song.dart';
import '../../bloc/item_select/itemselect_bloc.dart';
import '../../bloc/item_select/itemselect_event.dart';
import 'component_main_fragment_selected.dart';

class MainFragmentContainer extends StatefulWidget {
  const MainFragmentContainer({super.key});

  @override
  _MainFragmentContainerState createState() => _MainFragmentContainerState();
}

class _MainFragmentContainerState extends State<MainFragmentContainer> {
  int selectedPosition = -1;
  final ApiBloc _apiBloc = ApiBloc();
  final ItemSelectBloc _itemSelectBloc = ItemSelectBloc();

  @override
  void initState() {
    _apiBloc.add(GetSongList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) => _apiBloc,
        child: BlocConsumer<ApiBloc, ApiState>(
            buildWhen: (context, state) {
              return state is SongLoaded;
            },
            builder: (context, state) {
              if (state is SongLoading) {
                return _buildLoading();
              } else if (state is SongLoaded) {
                return _buildContentView(context, state.songModel);
              } else if (state is SongError) {
                return _buildEmptyView();
              } else {
                return _buildEmptyView();
              }
            },
            listenWhen: (context, state) {
              return state is SongError;
            },
            listener: (context, state) {
              if (state is SongError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            }
        ),
      ),
    );
  }

  // if list is not exist, show this view
  Widget _buildEmptyView() => Container();

  // if list is still loading, show this view
  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  // if list is exist, show this view
  Widget _buildContentView(BuildContext context, SongModel listSong) {
    return BlocProvider(
      create: (context) => _itemSelectBloc,
      child: BlocConsumer<ItemSelectBloc, ItemSelectState>(
          builder: (context, state) {
            selectedPosition = state.index;

            return Column(
              children: [
                _buildBodyHeader(state),
                _buildBodyList(listSong)
              ],
            );
          },
          listener: (context, state) {}
      ),
    );
  }

  Widget _buildBodyHeader(ItemSelectState state) {
    return Flexible(
      flex: 0,
      child: Container(
        padding: EdgeInsets.all(10),
        color: ColorConstant.primaryColor,
        height: 100,
        child: Column(
          children: ComponentMainFragmentSelected().showButtonSeeDetailSong(context, state.songNameSelected),
        ),
      ),
    );
  }

  Widget _buildBodyList(SongModel listSong) {
    return Flexible(
      flex: 1,
      child: Container(
              child: ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: listSong.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(listSong.data[index].image_url.toString()),
                    ),
                    tileColor: selectedPosition == index ? ColorConstant.blue : null,
                    title: Text(listSong.data[index].song_name.toString()),
                    subtitle: Text(listSong.data[index].song_by.toString()),
                    onTap: () {
                      _itemSelectBloc.add(ItemSelectEvent(index: index, songNameSelected: listSong.data[index]));
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
      ),
      );
  }
}
