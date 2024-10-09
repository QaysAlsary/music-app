import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

import '../../bloc/tracks_bloc.dart';
import '../../model/position_info.dart';
import '../../src/themes/app_colors.dart';
import '../../src/util/app_sizes.dart';

class MainProgressBar extends StatelessWidget {
  const MainProgressBar({
    super.key,
    required this.context,
    required this.bloc,
  });

  final BuildContext context;
  final TracksBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PositionInfo>(
      stream: bloc.positionInfoStream,
      builder: (context, snapshot) {
        final positionInfo = snapshot.data;
        return ProgressBar(
          barHeight: ResponsiveSize.getResponsiveValue(
            context: context,
            small: 4,
            medium: 5,
            large: 6,
          ),
          bufferedBarColor: AppColors.grey,
          baseBarColor: AppColors.grey600,
          progressBarColor: AppColors.white,
          thumbColor: AppColors.white,
          timeLabelTextStyle: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: ResponsiveSize.getResponsiveValue(
              context: context,
              small: 12,
              medium: 14,
              large: 16,
            ),
          ),
          progress: positionInfo?.position ?? Duration.zero,
          buffered: positionInfo?.bufferedPosition ?? Duration.zero,
          total: positionInfo?.duration ?? Duration.zero,
          onSeek: bloc.player.seek,
        );
      },
    );
  }
}