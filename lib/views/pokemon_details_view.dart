// ignore_for_file: avoid_print, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';

import 'package:percent_indicator/percent_indicator.dart';

import 'pokemon_moves_screen.dart';

// ! REFACTOR FUNCTIONS

int extractPokemonSpeciesId(String url) {
  final regex = RegExp(r'/(\d+)/$');
  final match = regex.firstMatch(url);
  if (match != null) {
    return int.parse(match.group(1)!);
  } else {
    throw Exception('Invalid Pokemon species URL');
  }
}

String decimetersToMeters(double decimeters) {
  double meters = decimeters / 10.0;
  return meters.toStringAsFixed(2);
}

String hectogramsToKilograms(double hectograms) {
  double kilograms = hectograms * 0.1;
  return kilograms.toStringAsFixed(2);
}

String capitalize(String s) {
  if (s.isEmpty) {
    return s;
  }
  return s[0].toUpperCase() + s.substring(1);
}

double getGenderRatio(int genderRate) {
  if (genderRate == -1) {
    // Genderless, so male ratio is 0
    return 0.0;
  }

  // Calculate the ratio of male to female
  double maleRatio = (8 - genderRate) / 8;

  // Return the male ratio as a double
  return maleRatio;
}

String getGenderRatioString(double genderRate) {
  if (genderRate == 0.0) {
    // Genderless
    return 'Genderless';
  }

  // Calculate the ratio of male to female
  double maleRatio = genderRate * 100;
  double femaleRatio = 100 - maleRatio;

  // Format the ratios as percentages with two decimal places
  String formattedMaleRatio = maleRatio.toStringAsFixed(1);
  String formattedFemaleRatio = femaleRatio.toStringAsFixed(1);

  // Return the formatted gender ratios as a string
  return '$formattedMaleRatio% Male, $formattedFemaleRatio% Female';
}

class PokemonDetailsView extends StatefulWidget {
  final String pokemon;
  const PokemonDetailsView({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<PokemonDetailsView> createState() => _PokemonDetailsViewState();
}

class _PokemonDetailsViewState extends State<PokemonDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Flutterdex'),
        ),
        body: SingleChildScrollView(
          child: Center(),
        ));
  }
}
