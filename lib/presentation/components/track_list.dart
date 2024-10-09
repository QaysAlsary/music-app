import 'package:flutter/material.dart';
import 'package:musicapp/presentation/components/track_list_tile.dart';

import '../../bloc/tracks_bloc.dart';
import '../../src/util/app_sizes.dart';

class TrackList extends StatelessWidget {
  const TrackList({
    super.key,
    required this.context,
    required this.bloc,
    required this.constraints,
  });

  final BuildContext context;
  final TracksBloc bloc;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = ResponsiveSize.getResponsiveValue(
      context: context,
      small: 1,
      medium: 2,
      large: 3,
    ).toInt();

    return Padding(
      padding: EdgeInsets.all(ResponsiveSize.getResponsiveValue(
        context: context,
        small: 8,
        medium: 12,
        large: 16,
      )),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: bloc.tracks!.length,
        itemBuilder: (context, index) {
          return TrackListTile(tracks: bloc.tracks![index], bloc: bloc, index: index);
        },
      ),
    );
  }
}