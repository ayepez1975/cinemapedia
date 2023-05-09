import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
      final movieDetail = ref.watch(movieRepositoryProviderImpl);
   return  MovieMapNotifier(getMovie: movieDetail.getMovieById);
});


typedef GetMovieCallBack = Future<Movie>Function(String moveId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {

  MovieMapNotifier(
  {required this.getMovie,}
  ) : super({});

  final GetMovieCallBack getMovie;

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    print('realizando la peticion http');
    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};
   }


}
