import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme;

    return SafeArea(
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie_outlined,
                color: colors.primary,
              ),
              const SizedBox(width: 5),
              Text(
                'Cinemapedia',
                style: titleStyle.titleMedium,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  //final searchMovies = ref.read(searchMoviesProvider);

                  final serchQuery = ref.read(searchQueryProvider);

                  showSearch<Movie?>(
                    query: serchQuery,
                    context: context,
                    delegate: SearchMovieDelegate(
                        searchMovies: ref.read(searchMoviesProvider.notifier).searchMovieByQuery, ref: ref),
                  ).then((movie) {
                    if (movie == null) return;
                    context.push('/movie/${movie.id}');
                  });

                  //  if( movie != null) {
                  //
                  //  }
                },
                icon: Icon(
                  Icons.search,
                  color: colors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
