
import 'package:flutter/material.dart';

import '../../bloc/tracks_bloc.dart';
import '../../src/themes/app_colors.dart';
import '../../src/util/app_sizes.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    super.key,
    required this.bloc,
    required this.context,
  });

  final TracksBloc bloc;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (bloc.player.playing) {
          bloc.player.pause();
        } else {
          bloc.player.play();
        }
      },
      color: AppColors.white,
      iconSize: ResponsiveSize.getResponsiveValue(
        context: context,
        small: 32,
        medium: 40,
        large: 48,
      ),
      icon: Icon(
        bloc.player.playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
      ),
    );
  }
}