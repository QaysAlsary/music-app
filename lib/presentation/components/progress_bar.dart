import 'package:flutter/material.dart';

import '../../bloc/tracks_bloc.dart';
import '../../model/position_info.dart';
import '../../src/themes/app_colors.dart';

class MiniProgressBar extends StatelessWidget {
  const MiniProgressBar({
    super.key,
    required this.bloc,
    required this.constraints,
  });

  final TracksBloc bloc;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PositionInfo>(
        stream: bloc.positionInfoStream,
        builder: (context, snapshot) {
          final positionInfo = snapshot.data;
          if (positionInfo == null || positionInfo.duration.inMilliseconds == 0) {
            return SizedBox(height: 4);
          }
          final progress = positionInfo.position.inMilliseconds / positionInfo.duration.inMilliseconds;
          final width = progress.isFinite ? progress * constraints.maxWidth : 0.0;
          return Container(
            width: double.infinity,
            height: 4,
            color: Colors.white54,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: width,
                height: 4,
                color: AppColors.white,
              ),
            ),
          );
        }
    );
  }
}