import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/models/movie_model.dart';
import '../../models/common_response_model.dart';
import '../../services/apii_service.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  ApiService apiService = ApiService();
  late CommonResponseModel? commonResponseModel;
  MovieModel movieModel = MovieModel();

  MovieBloc() : super(MovieInitial()) {
    on<GetMovieList>((event, emit) async {
      try {
        emit(MovieLoading());
        final response = await apiService.apiCall(
          'trending/movie/day?language=en-US&page=${event.page}',
        );
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['results'] != []) {
            movieModel = MovieModel.fromJson(responseData);
            emit(MovieSuccess(movieModel: movieModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(MovieFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          emit(MovieFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(MovieFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
