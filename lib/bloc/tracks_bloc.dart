import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musicapp/model/position_info.dart';
import 'package:musicapp/src/util/app_messages.dart';
import 'package:rxdart/rxdart.dart';
import 'package:palette_generator/palette_generator.dart';
import '../model/traks_model.dart';
import '../src/util/app_toasts.dart';

part 'tracks_event.dart';
part 'tracks_state.dart';

class TracksBloc extends Bloc<TracksEvent, TracksState> {
  TracksBloc() : super(const TracksState()) {
    on<LoadJsonFileEvent>(_readJson);
    on<PlaySongAtIndexEvent>(_playAtIndex);
    on<SearchTermChangedEvent>(_onSearchTermChanged);
    on<UpdateBackgroundColorEvent>(_updateBackgroundColor);
  }
   String? response;
  List<Tracks>? tracks;
  List<Map<String, dynamic>> songs = [];
  ConcatenatingAudioSource? playlist;
   bool songSelected=false;
  final player = AudioPlayer();

  FutureOr<void> _readJson(LoadJsonFileEvent event, Emitter<TracksState> emit)async {
    emit(state.copyWith(isLoading: true));
    try {
      await _loadJsonData();
      await _parseJsonData();
      await _setupAudioSource();
    }catch(e){
      showToast("something happened while loading your songs",ToastStates.Error);
    }
    emit(state.copyWith(isLoading: false));
  }
//here i'm loading the json file from the assets
  Future<void> _loadJsonData() async {
    response = await rootBundle.loadString('assets/songs_not_matching.json');
  }
// parsing it
  Future<void> _parseJsonData() async {
    tracks = tracksFromJson(response!);
    songs = List<Map<String, dynamic>>.from(jsonDecode(response!));
  }
// setting the audio source
  Future<void> _setupAudioSource() async {
    playlist = ConcatenatingAudioSource(
      children: songs.map((song) {
        return AudioSource.uri(Uri.parse(song['streamingUrl']),
            tag: MediaItem(
              id: song['id'].toString(),
              title: song['title'],
              artist: song['artist'],
              artUri: Uri.parse(song['albumArtUrl']),
            ));
      }).toList(),
    );
    await player.setLoopMode(LoopMode.all);
    await player.setAudioSource(playlist!);
  }
  Stream<PositionInfo> get positionInfoStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionInfo>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
            (position, bufferedPosition, duration) => PositionInfo(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      ).where((info) => info.duration.inMilliseconds > 0);
// playing a song from the songs list
  FutureOr<void> _playAtIndex(PlaySongAtIndexEvent event, Emitter<TracksState> emit) async {
    try{
      await player.seek(Duration.zero, index: event.index);
      await player.play();
      songSelected = true;
      await for (final metadata in player.sequenceStateStream) {
        if (metadata != null && metadata.currentSource != null) {
          final imageUrl =
              (metadata.currentSource!.tag as MediaItem).artUri?.toString();
          if (imageUrl != null) {
            add(UpdateBackgroundColorEvent(imageUrl));
            break;
          }
        }
      }
    }catch(e){
      emit(TracksErrorState(message: e.toString()));
      showToast(AppMessages.playingSongErrorMessage,ToastStates.Error);
    }
  }
  //filtering the search results
  void _onSearchTermChanged(SearchTermChangedEvent event, Emitter<TracksState> emit) {
    try{
      final searchTerm = event.searchTerm.toLowerCase();
      final filteredSongs =searchTerm.isEmpty ?
      tracks : _filterTracks(searchTerm);

      emit(state.copyWith(searchResult: filteredSongs, searchTerm: searchTerm));
    }catch(e){
      emit(TracksErrorState(message: e.toString()));
      showToast(AppMessages.searchResultsErrorMessage,ToastStates.Error);
    }
  }
  List<Tracks> _filterTracks(String searchTerm) {
    final lowercaseSearchTerm = searchTerm.toLowerCase();
    return state.searchResult.where((track) {
      final lowercaseTitle = track.title?.toLowerCase() ?? '';
      final lowercaseArtist = track.artist?.toLowerCase() ?? '';
      return lowercaseTitle.contains(lowercaseSearchTerm) || lowercaseArtist.contains(lowercaseSearchTerm);
    }).toList();
  }
// here i'm changing the color for the background based of the color of the cover image
  FutureOr<void> _updateBackgroundColor(UpdateBackgroundColorEvent event, Emitter<TracksState> emit) async {
    try{
      if (event.imageUrl != null && event.imageUrl.isNotEmpty) {
        try {
          final backgroundColor =  await _extractDominantColor(event.imageUrl);
          emit(state.copyWith(backgroundColor: backgroundColor));
        } catch (e) {
          print('Error extracting color: $e');
          emit(state.copyWith(
              backgroundColor: Colors.deepPurple)); // Fallback color
        }
      }
    }catch(e){
      emit(TracksErrorState(message: e.toString()));
      showToast(AppMessages.backgroundColorErrorMessage,ToastStates.Error);
    }
  }
  Future<Color> _extractDominantColor(String imageUrl) async {
    final imageProvider = NetworkImage(imageUrl);
    final paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color ?? Colors.deepPurple;
  }
}
