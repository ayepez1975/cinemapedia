import 'package:flutter/material.dart';

class FavoritiesView extends StatelessWidget {
  static const routeName = 'FavoritiesViewScreen';
  const FavoritiesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FavoritiesView'),
      ),
      body: Container(
        child: Center(
          child: Text('FavoritiesViewScreen'),
        ),
      ),
    );
  }
}
