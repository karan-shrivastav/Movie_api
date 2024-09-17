import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMovieList extends MovieEvent {
  final int page;
  GetMovieList({required this.page});
  @override
  List<Object?> get props => [page];
}
