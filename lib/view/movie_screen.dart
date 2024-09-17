import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_bloc/movie_bloc.dart';
import '../bloc/movie_bloc/movie_event.dart';
import '../bloc/movie_bloc/movie_state.dart';
import '../widgets/text_widget.dart';
import 'movie_detail_screen.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(GetMovieList(page: _currentPage));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _currentPage++;
        context.read<MovieBloc>().add(GetMovieList(page: _currentPage));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const TextWidget(
            text: 'The MovieDb',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
            if (state is MovieSuccess) {
              return Expanded(
                child: GridView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: state.movieModel.results?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailScreen(
                              name: state.movieModel.results?[index].title,
                              image:
                                  "https://image.tmdb.org/t/p/w500${state.movieModel.results?[index].posterPath}",
                              mediaType:
                                  state.movieModel.results?[index].mediaType,
                              date:
                                  state.movieModel.results?[index].releaseDate,
                              overview:
                                  state.movieModel.results?[index].overview,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://image.tmdb.org/t/p/w500${state.movieModel.results?[index].posterPath}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
        ],
      ),
    );
  }
}
