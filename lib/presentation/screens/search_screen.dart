import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/presentation/components/track_list_tile.dart';
import '../../bloc/tracks_bloc.dart';
import '../../src/util/app_sizes.dart';
import '../components/search_bar.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = context.read<TracksBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Songs'),
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              MySearchBar(bloc: bloc),
              Expanded(
                child: BlocBuilder<TracksBloc, TracksState>(
                  builder: (context, state) {
                    return _buildSearchResults(context, state, bloc, constraints);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, TracksState state, TracksBloc bloc, BoxConstraints constraints) {
    final crossAxisCount = ResponsiveSize.getResponsiveValue(
      context: context,
      small: 1,
      medium: 2,
      large: 3,
    ).toInt();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: state.searchResult.length,
      itemBuilder: (context, index) {
        final searchResult = state.searchResult[index];
        return TrackListTile(
          tracks: searchResult,
          bloc: bloc,
          index: index,
        );
      },
    );
  }
}