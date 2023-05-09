import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
          GoRoute(
              path: '/home/:page',
              builder: (context, state) {
                final pageIndex = int.parse(state.params['page'] ?? '0');

                return  HomeScreen(pageindex:pageIndex);
              },
              routes: [
                GoRoute(
                    path: 'movie/:id',
                    name: MovieScreen.routeName,
                    builder: (context, state) {
                      final movieId = state.params['id'] ?? 'no-id';
                      return MovieScreen(movieId: movieId);
                    }),
              ]),
            GoRoute(
              path: '/',
              redirect: (context, state) => '/home/0' ,
            )

        ]
        
  
);


