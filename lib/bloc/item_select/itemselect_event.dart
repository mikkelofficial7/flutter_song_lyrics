import 'package:equatable/equatable.dart';
import 'package:sample_flutter/model/model_song.dart';

class ItemSelectEvent extends Equatable {
  final int index;
  final ItemSongModel songNameSelected;

  const ItemSelectEvent({
    required this.index,
    required this.songNameSelected
  });

  @override
  List<Object> get props => [index, songNameSelected];
}