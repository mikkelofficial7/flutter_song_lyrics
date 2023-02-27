import 'package:equatable/equatable.dart';
import 'package:sample_flutter/model/model_song.dart';

class ItemSelectState extends Equatable {
  final int index;
  final ItemSongModel? songNameSelected;

  const ItemSelectState.noChoose() : index = -1, songNameSelected = null;

  const ItemSelectState({
    required this.index,
    required this.songNameSelected
  });

  @override
  List<Object?> get props => [index, songNameSelected];
}
