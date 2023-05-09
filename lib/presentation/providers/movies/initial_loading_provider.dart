import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final slideShowMovies = ref.watch(moviesSlideShowProvider).isEmpty;
  final popularMovies = ref.watch(popularMoviesProvider).isEmpty;
  final upComingMovies = ref.watch(upComingMoviesProvider).isEmpty;
  final topRatedMovies = ref.watch(topRatedMoviesProvider).isEmpty;

  if (nowPlayingMovies ||
      slideShowMovies ||
      popularMovies ||
      upComingMovies ||
      topRatedMovies ||
      false) return true;

  return false;
});
