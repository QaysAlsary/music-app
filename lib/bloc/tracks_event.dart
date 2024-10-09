part of 'tracks_bloc.dart';

 class TracksEvent extends Equatable {
  const TracksEvent();
  @override
  List<Object> get props => [];
}
class LoadJsonFileEvent extends TracksEvent{}
class PlaySongAtIndexEvent extends TracksEvent{
  final int index;
  const PlaySongAtIndexEvent({required this.index});
}
class SearchTermChangedEvent extends TracksEvent{
   final String searchTerm;
   const SearchTermChangedEvent({required this.searchTerm});
}
class UpdateBackgroundColorEvent extends TracksEvent {
  final String imageUrl;

  const UpdateBackgroundColorEvent(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}
