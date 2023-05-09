import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infraestructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infraestructure/models/movieDB/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorDataSource{

   final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
      final response = await dio.get('/movie/$movieId/credits');
      final  actorDbResponse = CreditsResponse.fromJson(response.data);

      final List<Actor> cast = actorDbResponse.cast
      .map((castdb) => ActorMapper.castToEntity(castdb))
      .toList();

    return cast;
        
    
  }
} 