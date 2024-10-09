import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musicapp/model/position_info.dart';
import 'package:musicapp/presentation/components/controls.dart';
import 'package:musicapp/presentation/components/media_meta_data.dart';
import 'package:musicapp/src/themes/app_colors.dart';
import '../../bloc/tracks_bloc.dart';
import '../../src/util/app_sizes.dart';
import '../components/main_progress_bar.dart';

class TrackPlayerScreen extends StatelessWidget {
  const TrackPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TracksBloc, TracksState>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = context.read<TracksBloc>();
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.keyboard_arrow_down_rounded)),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(ResponsiveSize.getResponsiveValue(
              context: context,
              small: 16,
              medium: 24,
              large: 32,
            )),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [state.backgroundColor, state.backgroundColor.withOpacity(0.6)],
              ),
            ),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildMediaMetaData(context, bloc),
                          SizedBox(height: ResponsiveSize.getResponsiveValue(
                            context: context,
                            small: 20,
                            medium: 30,
                            large: 40,
                          )),
                          MainProgressBar(context: context, bloc: bloc),
                          SizedBox(height: ResponsiveSize.getResponsiveValue(
                            context: context,
                            small: 20,
                            medium: 30,
                            large: 40,
                          )),
                          Controls(audioPlayer: bloc.player)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMediaMetaData(BuildContext context, TracksBloc bloc) {
    return StreamBuilder<SequenceState?>(
      stream: bloc.player.sequenceStateStream,
      builder: (context, snapshot) {
        final sequenceState = snapshot.data;
        if (sequenceState?.sequence.isEmpty ?? true) {
          return const SizedBox();
        }
        final metaData = sequenceState!.currentSource!.tag as MediaItem;
        bloc.add(UpdateBackgroundColorEvent(metaData.artUri.toString()));
        return MediaMetaData(
          imageUrl: metaData.artUri.toString(),
          title: metaData.title,
          artist: metaData.artist ?? '',
        );
      },
    );
  }
}