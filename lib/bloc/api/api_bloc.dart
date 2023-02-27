import 'package:equatable/equatable.dart';
import 'package:sample_flutter/api/repository/api_repository.dart';
import 'package:sample_flutter/bloc/api/api_event.dart';
import 'package:sample_flutter/bloc/api/api_state.dart';
import 'package:bloc/bloc.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(SongLoading()) {
    final ApiRepository _apiRepository = ApiRepository();

    on((event, emit) async {
      try {
        final mList = await _apiRepository.fetchListSong();
        print("reach here: Start to get data");

        if (mList.status == false) {
          emit(const SongError(404, "Failed to fetch data. data is not found"));
          print("reach here: Failed to get data because of 404");
        } else {
          emit(SongLoaded(mList));
          print("reach here: Success to get ${mList.data.length} data");
        }
      } on Exception catch (e) {
        emit(const SongError(500, "Failed to fetch data. is your device online?"));
        print("reach here: Failed to get data because of 500");
      }
    });
  }
}