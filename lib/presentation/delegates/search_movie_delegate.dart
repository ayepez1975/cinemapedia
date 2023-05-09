import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final List<Movie> initialMovies;
  final SearchMoviesCallback searchMovies;
  final WidgetRef ref;

  // Crearun DebounceManual
  final StreamController<List<Movie>> debouncedMovies =
      StreamController.broadcast();
  final StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        debouncedMovies.add([]);
        return;
      }
      final movies = await searchMovies(query);
      debouncedMovies.add(movies);
      isLoadingStream.add(false);
    });
  }

  void dispose() {
    debouncedMovies.close();
    isLoadingStream.close();
  }

  SearchMovieDelegate(
      {required this.searchMovies,
      this.initialMovies = const [],
      required this.ref});

  @override
  String get searchFieldLabel => 'Buscar';

  TextStyle get searchFieldStyle =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w200);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
          stream: isLoadingStream.stream,
          initialData: false,
          builder: (context, snapshot) {
            if (snapshot.data ?? false) {
              return SpinPerfect(
                duration: const Duration(seconds: 10),
                infinite: true,
                spins: 10,
                child: IconButton(
                  onPressed: () {
                    ref
                        .read(searchQueryProvider.notifier)
                        .update((state) => query = '');
                  },
                  //=> query = '',
                  icon: Icon(Icons.refresh_rounded),
                ),
              );
            } 

            return FadeIn(
              animate: query.isEmpty,
              child: IconButton(

                onPressed:  (){
                   ref
                        .read(searchQueryProvider.notifier)
                        .update((state) => query = '');
                },
                icon: const Icon(Icons.clear),
              )
                
                 );
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return FadeIn(
      child: IconButton(
          onPressed: () => {
                dispose(),
                close(context, null),
              },
          icon: const Icon(Icons.close)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
        stream: debouncedMovies.stream,
        builder: (context, snapshot) {
          _onQueryChanged(query);

          final movies = snapshot.data ?? [];

          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                return _titulos(
                  movie: movie,
                  onMovieSelected: (context, movie) {
                    dispose();
                    close(context, movie);
                  },
                );
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return StreamBuilder(
        initialData: initialMovies,
        stream: debouncedMovies.stream,
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];

          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                return _titulos(
                  movie: movie,
                  onMovieSelected: (context, movie) {
                    dispose();
                    close(context, movie);
                  },
                );
              });
        });
  }
}

class _titulos extends StatelessWidget {
  const _titulos({required this.movie, required this.onMovieSelected});

  final Movie movie;
  final Function onMovieSelected;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.fill,
                  width: size.width * 0.2,
                  height: size.height * 0.11,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleMedium),
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_outlined,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyle.bodyMedium
                            ?.copyWith(color: Colors.yellow.shade800),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
