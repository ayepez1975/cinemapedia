import 'package:cinemapedia/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infraestructure/models/movieDB/movidb_response.dart';
import 'package:cinemapedia/infraestructure/models/movieDB/movie_details.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';

class MoviedbDatasource extends MoviesDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    return getMovies('/movie/now_playing', page);
  }

  @override
  Future<List<Movie>> getPopularPlaying({int page = 1}) async {
    return getMovies('/movie/popular', page);
  }

  @override
  Future<List<Movie>> getMoviesUpcoming({int page = 1}) {
    return getMovies('/movie/upcoming', page);
  }

  Future<List<Movie>> getMovies(String url, int page) async {
    final response = await dio.get(url, queryParameters: {"page": page});
    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDbToEntity(moviedb))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getMoviesTopRated({int page = 1}) {
    return getMovies('/movie/top_rated', page);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200)
      throw Exception('Movie with id: $id not found');
    final movieDetails = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }

  @override
  Future<List<Movie>> searchMovie(String query) async {
    if (query.isEmpty) return [];
    final response =
        await dio.get('/search/movie', queryParameters: {'query': query});

    if (response.statusCode != 200)
      throw Exception('Movies with $query not found');

    final movieDetails = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDetails.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDbToEntity(moviedb))
        .toList();

    return movies;
  }
}
