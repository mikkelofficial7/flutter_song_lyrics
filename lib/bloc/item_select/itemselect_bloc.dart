import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter/bloc/item_select/itemselect_event.dart';
import 'package:sample_flutter/bloc/item_select/itemselect_state.dart';

class ItemSelectBloc extends Bloc<ItemSelectEvent, ItemSelectState> {
  ItemSelectBloc() : super(const ItemSelectState.noChoose()) {
    on<ItemSelectEvent>((event, emit) {
      print("item click index: ${event.index} - ${event.songNameSelected.song_name}");
      emit(ItemSelectState(index: event.index, songNameSelected: event.songNameSelected));
    });
  }
}