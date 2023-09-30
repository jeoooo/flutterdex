import 'package:flutter/material.dart';
import 'package:flutterdex/data/models/pokemon_model.dart';
import 'package:flutterdex/viewmodels/pokemon_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FlutterDex Home'),
        ),
        body: Text('data'));
  }
}
