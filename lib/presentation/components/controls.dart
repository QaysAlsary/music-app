import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicapp/src/themes/app_colors.dart';

class Controls extends StatelessWidget {
  const Controls({super.key,required this.audioPlayer});
 final AudioPlayer audioPlayer;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: audioPlayer.seekToPrevious,
            iconSize: 60,
            color: AppColors.white,
            icon: const Icon(Icons.skip_previous_rounded)),
        StreamBuilder<PlayerState>(
            stream: audioPlayer.playerStateStream,
            builder: (context,snapshot){
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if(!(playing ?? false)){
                return IconButton(
                    onPressed: audioPlayer.play,
                    iconSize: 80,
                    color: Colors.white,
                    icon:const Icon(Icons.play_arrow_rounded));
              }else if (processingState != ProcessingState.completed){
                return IconButton(onPressed: audioPlayer.pause,
                    iconSize: 80,
                    color: Colors.white,
                    icon: const Icon(Icons.pause_rounded));
              }
              return const Icon(
                Icons.play_arrow_rounded,
                size: 80,
                color: Colors.white,);
            }),
        IconButton(
            onPressed: audioPlayer.seekToNext,
            iconSize: 60,
            color: AppColors.white,
            icon: const Icon(Icons.skip_next_rounded)),
      ],
    );
  }
}
