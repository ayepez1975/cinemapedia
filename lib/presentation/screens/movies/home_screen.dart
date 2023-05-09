import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/views/movies/home_views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';

import '../../views/views.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'HomeScreen';
  final int pageindex;

  
    final viewRoutes = const <Widget>[
      HomeView(),
      SizedBox(),
      FavoritiesView()
    ];

  const HomeScreen({super.key, required this.pageindex});
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Center(
        child: IndexedStack(
          index: pageindex,
          children: viewRoutes,
        )
      ),
      bottomNavigationBar:  CustomBottomNavigation(currentIndex: pageindex,),
    );
  }
}
