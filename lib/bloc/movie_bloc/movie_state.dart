import 'package:equatable/equatable.dart';
import '../../models/common_response_model.dart';
import '../../models/movie_model.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieSuccess extends MovieState {
  final MovieModel movieModel;

  MovieSuccess({required this.movieModel});

  @override
  List<Object?> get props => [movieModel];
}

class MovieFail extends MovieState {
  final CommonResponseModel commonResponseModel;

  MovieFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
