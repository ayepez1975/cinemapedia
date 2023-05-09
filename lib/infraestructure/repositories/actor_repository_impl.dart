
 

import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actor_repository.dart';

class ActorRepositoryImpl extends ActorRepository {
 final ActorDataSource dataSource;

  ActorRepositoryImpl(this.dataSource);

  
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
     return dataSource.getActorsByMovie(movieId);
  }

  


}