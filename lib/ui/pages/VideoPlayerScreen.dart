import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notekeeperatg/blocs/video_player.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String url;
  const VideoPlayerScreen({Key key,@required this.url}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var controller = VideoPlayerController.network(url);
    print(url);
    var initializer = controller.initialize();
    controller.setLooping(true);
    return BlocProvider(
        create: (context)=>VideoPlayerCubit(false),
        child: Scaffold(
            appBar: AppBar(title: Text("Video Player"),),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    FutureBuilder(
                        future: initializer,
                        builder: (context,snapshot){
                          if(snapshot.connectionState == ConnectionState.done){
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(5,20,5,50),
                              child: AspectRatio(aspectRatio: controller.value.aspectRatio,child: VideoPlayer(controller),),
                            );
                          }else{
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(16,50,16,50),
                              child: Center(child: CircularProgressIndicator(),),
                            );
                          }
                        }
                    ),
                    BlocBuilder<VideoPlayerCubit,VideoPlayerState>(
                        builder:(context,state){
                          if(state is VideoPlayerInitial){
                            return FloatingActionButton(onPressed: (){
                              if(state.playState){
                                controller.pause();
                              }else{
                                controller.play();
                              }
                              BlocProvider.of<VideoPlayerCubit>(context).setPlaying(!state.playState);
                            }, child: Icon((state.playState)?Icons.pause : Icons.play_arrow));
                          }
                          return Text("");
                        }
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
