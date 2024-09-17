import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/widgets/text_widget.dart';
import '../bloc/movie_bloc/movie_bloc.dart';
import '../bloc/movie_bloc/movie_state.dart';
import '../models/movie_model.dart';
import '../widgets/textfield_widget.dart';
import 'movie_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Results>? results = [];
  List<Results> filteredMovies = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchMovies);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchMovies() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      if (query.isNotEmpty) {
        filteredMovies = results!.where((movie) {
          return movie.title!.toLowerCase().contains(query);
        }).toList();
      } else {
        filteredMovies = results!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const TextWidget(
              text: 'Search',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 20,
            ),
            TextfieldWidget(
              hintText: 'Search',
              controller: _searchController,
            ),
            Expanded(
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is MovieSuccess) {
                    results = state.movieModel.results ?? [];
                    filteredMovies =
                        filteredMovies.isEmpty && _searchController.text.isEmpty
                            ? results!
                            : filteredMovies;

                    return ListView.builder(
                      itemCount: filteredMovies.length,
                      itemBuilder: (context, index) {
                        String dateString =
                            filteredMovies[index].releaseDate ?? '';
                        DateTime date =
                            DateTime.parse(dateString.replaceAll('/', '-'));
                        int year = date.year;
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDetailScreen(
                                        name: filteredMovies[index].title,
                                        image:
                                            "https://image.tmdb.org/t/p/w500${filteredMovies[index].posterPath}",
                                        mediaType:
                                            filteredMovies[index].mediaType,
                                        date: filteredMovies[index].releaseDate,
                                        overview:
                                            filteredMovies[index].overview,
                                      )),
                            );
                          },
                          title: TextWidget(
                            text: filteredMovies[index].title ?? '',
                          ),
                          subtitle: TextWidget(
                            text: '$year',
                          ),
                        );
                      },
                    );
                  }
                  if (state is MovieFail) {
                    return const Center(child: Text("Error..."));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
