part of 'tracks_bloc.dart';

 class TracksState extends Equatable {
   final bool isLoading;
   final List<Tracks> searchResult;
   final String searchTerm;
   final Color backgroundColor;
  const TracksState({
     this.isLoading=false,
    this.searchResult=const [],
    this.searchTerm='',
    this.backgroundColor = Colors.deepPurple,
 });
   @override
   List<Object> get props => [
     isLoading,
     searchResult,
     searchTerm,
     backgroundColor,
   ];
   TracksState copyWith({
     bool? isLoading,
     String? searchTerm,
     List<Tracks>? searchResult,
     Color? backgroundColor,
 })=> TracksState(
       isLoading: isLoading ?? this.isLoading,
       searchResult: searchResult ?? this.searchResult,
       searchTerm: searchTerm ?? this.searchTerm,
     backgroundColor: backgroundColor ?? this.backgroundColor,
   );
}
class TracksErrorState extends TracksState{
   final String message;
   const TracksErrorState({required this.message});
}


