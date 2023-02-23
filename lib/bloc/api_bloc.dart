import 'package:equatable/equatable.dart';
import 'package:sample_flutter/api/repository/api_repository.dart';
import 'package:sample_flutter/bloc/api_event.dart';
import 'package:sample_flutter/bloc/api_state.dart';
import 'package:bloc/bloc.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(SongInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetSongList>((event, emit) async {
      try {
        emit(SongLoading());
        final mList = await _apiRepository.fetchListSong();
        emit(SongLoaded(mList));

        if (mList.status == false) {
          emit(const SongError(404, "Failed to fetch data. data is not found"));
        
      } on NetworkError {
        emit(const SongError(503, "Failed to fetch data. is your device online?"));
      }
    });
  }
}