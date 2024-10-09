import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicapp/model/traks_model.dart';
import 'package:musicapp/presentation/components/play_pause_button.dart';
import 'package:musicapp/presentation/components/progress_bar.dart';
import 'package:musicapp/presentation/components/track_info.dart';
import 'package:musicapp/src/routing/routes.dart';

import '../../bloc/tracks_bloc.dart';
import '../../src/themes/app_colors.dart';
import '../../src/util/app_sizes.dart';
import 'additional_controls.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({
    super.key,
    required this.context,
    required this.bloc,
    required this.constraints,
    required this.state,
  });

  final BuildContext context;
  final TracksBloc bloc;
  final BoxConstraints constraints;
  final TracksState state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, Routes.trackPlayerRoute);
      },
      child: StreamBuilder<PlayerState>(
        stream: bloc.player.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          if (playerState?.playing == true || bloc.songSelected) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: state.backgroundColor,
                boxShadow: const [BoxShadow(color: AppColors.black26, blurRadius: 12.0)],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MiniProgressBar(bloc: bloc, constraints: constraints),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: ResponsiveSize.getResponsiveValue(
                          context: context,
                          small: 8,
                          medium: 16,
                          large: 24,
                        ),
                      ),
                      child: Row(
                        children: [
                          PlayPauseButton(bloc: bloc, context: context),
                          SizedBox(width: ResponsiveSize.getResponsiveValue(
                            context: context,
                            small: 8,
                            medium: 16,
                            large: 24,
                          )),
                          Expanded(child: TrackInfoWidget(context: context, bloc: bloc)),
                         // if (ResponsiveSize.isLargeScreen(context))
                            AdditionalControls(bloc: bloc, context: context,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}