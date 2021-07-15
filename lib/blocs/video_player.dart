
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit(bool playState) : super(VideoPlayerInitial(false));

  void setPlaying(bool playState) {
    emit(VideoPlayerInitial(playState));
  }


}

abstract class VideoPlayerState {}

class VideoPlayerInitial extends VideoPlayerState{
  bool playState;
  VideoPlayerInitial(this.playState);
}
