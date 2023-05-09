import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actor_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorMapNotifier, Map<String, List<Actor>>>((ref) {
  final actorRepository = ref.watch(actorRepositoryProviderImpl);
  return ActorMapNotifier(getActor: actorRepository.getActorsByMovie);
});

typedef GetCastCallBack = Future<List<Actor>> Function(String moveId);

class ActorMapNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetCastCallBack getActor;
  ActorMapNotifier({required this.getActor}) : super({});

  Future<void> loadActor(String movieId) async {
    if (state[movieId] != null) return;
    final actor = await getActor(movieId);
    state = {...state, movieId: actor};
  }
}
