import 'package:flutter/material.dart';

import '../../bloc/tracks_bloc.dart';
import '../../src/themes/app_colors.dart';
import '../../src/util/app_sizes.dart';

class AdditionalControls extends StatelessWidget {
  const AdditionalControls({
    super.key,
    required this.bloc,
    required this.context,
  });

  final TracksBloc bloc;
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous, color: AppColors.white),
          onPressed: ()async{
            print("88888888888888888888888888888");
           await bloc.player.seekToPrevious();
            bloc.add(UpdateBackgroundColorEvent(bloc.player.sequenceState!.currentSource!.tag!.artUri.toString()));
          },
          iconSize: ResponsiveSize.getResponsiveValue(
            context: context,
            small: 24,
            medium: 28,
            large: 32,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.skip_next, color: AppColors.white),
          onPressed: ()async {
           await bloc.player.seekToNext();
            bloc.add(UpdateBackgroundColorEvent(bloc.player.sequenceState!.currentSource!.tag!.artUri.toString()));
          },
          iconSize: ResponsiveSize.getResponsiveValue(
            context: context,
            small: 24,
            medium: 28,
            large: 32,
          ),
        ),
      ],
    );
  }
}