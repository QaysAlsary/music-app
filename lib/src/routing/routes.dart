import 'package:flutter/material.dart';
import 'package:musicapp/presentation/screens/search_screen.dart';
import 'package:musicapp/presentation/screens/track_player_screen.dart';
import 'package:musicapp/presentation/screens/tracks_list_screen.dart';

class Routes {
  static const String tracksListRoute = "/";
  static const String trackPlayerRoute = "/trackPlayer";
  static const String searchRoute = "/search";

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.tracksListRoute:
        return MaterialPageRoute(builder: (_) => const TracksListScreen());
      case Routes.trackPlayerRoute:
        return MaterialPageRoute(builder: (_) => const TrackPlayerScreen());
      case Routes.searchRoute:
        return MaterialPageRoute(builder: (_) =>  SearchScreen());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
                appBar: AppBar(
              title: const Text("no route found"),
            )));
  }
}
