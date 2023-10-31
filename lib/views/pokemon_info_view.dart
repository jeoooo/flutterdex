// ignore_for_file: avoid_print, prefer_const_constructors, non_constant_identifier_names, unused_local_variable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutterdex/controllers/pokemon_controller.dart';
import 'package:flutterdex/controllers/pokemon_species_controller.dart';

class PokemonInfo extends StatefulWidget {
  final String pokemon;
  const PokemonInfo({super.key, required this.pokemon});

  @override
  State<PokemonInfo> createState() => _PokemonInfoState();
}

class _PokemonInfoState extends State<PokemonInfo> {
  final pokemon_controller = PokemonController();
  final pokemon_species_controller = PokemonSpeciesController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column());
  }
}
