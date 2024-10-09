
import 'package:flutter/material.dart';
import 'package:musicapp/bloc/tracks_bloc.dart';
import 'package:musicapp/model/traks_model.dart';
import 'package:musicapp/src/routing/routes.dart';

class TrackListTile extends StatelessWidget {
  final Tracks tracks;
  final TracksBloc bloc;
  final int index;
  const TrackListTile({super.key, required this.tracks,required this.bloc,required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        title: Text(tracks.title!),
        subtitle: Text(tracks.artist!),
        leading: Image.network(
          tracks.albumArtUrl!,
          fit: BoxFit.cover,
          width: 40,
          height: 40,
        ),
        //trailing: Icon(Icons.chevron_right),
        onTap: () {
          bloc.add(PlaySongAtIndexEvent(index: tracks.id!-1));
          bloc.add(UpdateBackgroundColorEvent(tracks.albumArtUrl!));
        //Navigator.pushNamed(context, Routes.trackPlayerRoute);
        },
      ),
    );
  }
}

