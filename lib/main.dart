import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/presentation/screens/tracks_list_screen.dart';
import 'package:musicapp/src/routing/routes.dart';

import 'bloc/tracks_bloc.dart';
import 'src/di/app_initializer.dart';
import 'src/di/services_locator.dart';

void main()async {
  await AppInitializer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<TracksBloc>()..add(LoadJsonFileEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.tracksListRoute,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,

        ),
        home: const TracksListScreen(),
      ),
    );
  }
}


