import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/src/routing/routes.dart';
import '../../bloc/tracks_bloc.dart';
import '../components/mini_player.dart';
import '../components/track_list.dart';

class TracksListScreen extends StatelessWidget {
  const TracksListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tracks"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.searchRoute);
              },
              icon: const Icon(Icons.search)),
        ],
        centerTitle: true,
      ),
      body: BlocConsumer<TracksBloc, TracksState>(
        listener: (context, state) {},
        builder: (context, state) {
          var bloc = context.read<TracksBloc>();
          if (state.isLoading || bloc.tracks == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Expanded(
                      child: TrackList(
                          context: context,
                          bloc: bloc,
                          constraints: constraints),
                    ),
                    MiniPlayer(
                        context: context, bloc: bloc, constraints: constraints,state: state,),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
