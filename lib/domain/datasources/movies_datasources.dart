import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopularPlaying({int page = 1});
  Future<List<Movie>> getMoviesUpcoming({int page = 1});
  Future<List<Movie>> getMoviesTopRated({int page = 1});
  Future<Movie> getMovieById(String id);


  Future<List<Movie>> searchMovie ( String query);
  
}