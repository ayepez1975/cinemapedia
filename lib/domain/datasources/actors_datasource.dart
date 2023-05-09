


import 'package:cinemapedia/domain/entities/actor.dart';

abstract class ActorDataSource{

  
Future<List<Actor>> getActorsByMovie(String movieId);


}