import 'package:equatable/equatable.dart';
import 'package:sample_flutter/model/model_song.dart';

abstract class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object?> get props => [];
}

// like sealed class for state management
class SongLoading extends ApiState {}

class SongLoaded extends ApiState {
  final SongModel songModel;
  const SongLoaded(this.songModel);
}

class SongError extends ApiState {
  final int? errorCode;
  final String? message;
  const SongError(this.errorCode, this.message);
}