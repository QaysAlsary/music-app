import 'package:get_it/get_it.dart';
import 'package:musicapp/bloc/tracks_bloc.dart';


final sl = GetIt.instance;

class ServicesLocator {
  static setup() async {
    _injectBlocProviders();
  }

  static _injectBlocProviders() {
   sl.registerFactory(() => TracksBloc());

  }
}
