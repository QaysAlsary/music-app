import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../../bloc/tracks_bloc.dart';
import '../../src/themes/app_colors.dart';
import '../../src/util/app_sizes.dart';

class TrackInfoWidget extends StatelessWidget {
  const TrackInfoWidget({
    super.key,
    required this.context,
    required this.bloc,
  });

  final BuildContext context;
  final TracksBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>(
        stream: bloc.player.sequenceStateStream,
        builder: (context, snapshot) {
          final sequenceState = snapshot.data;
          final metaData = sequenceState?.currentSource?.tag as MediaItem?;
         // bloc.add(UpdateBackgroundColorEvent(metaData!.artUri.toString()));
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                metaData?.title ?? '',
                style: TextStyle(
                  fontSize: ResponsiveSize.getResponsiveValue(
                    context: context,
                    small: 14,
                    medium: 16,
                    large: 18,
                  ),
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                metaData?.artist ?? '',
                style: TextStyle(
                  fontSize: ResponsiveSize.getResponsiveValue(
                    context: context,
                    small: 12,
                    medium: 14,
                    large: 16,
                  ),
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              )
            ],
          );
        }
    );
  }
}