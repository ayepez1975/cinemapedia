import 'package:cinemapedia/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';


class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDataSource datasource;
  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
  
  @override
  Future<List<Movie>> getPopularPlaying({int page = 1}) {
    return datasource.getPopularPlaying(page: page);
  }
  
  @override
  Future<List<Movie>> getMoviesUpcoming({int page = 1}) {
    return datasource.getMoviesUpcoming(page: page);
  }
  
  @override
  Future<List<Movie>> getMoviesTopRated({int page = 1}) {
   return datasource.getMoviesTopRated(page: page);
  }
  
  @override
  Future<Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }
  
  @override
  Future<List<Movie>> searchMovie(String query) {
    return datasource.searchMovie(query);
  }
  

}
