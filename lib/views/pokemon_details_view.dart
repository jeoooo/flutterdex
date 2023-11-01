// ignore_for_file: avoid_print, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:pokedex/pokedex.dart';

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
  const PokemonDetailsView({
    Key? key,
    required pokemonId,
    required pokemonName,
    required type1,
    required typeColor1,
    required type2,
    required typeColor2,
    required String pokemon,
  }) : super(key: key);

  @override
  State<PokemonDetailsView> createState() => _PokemonDetailsViewState();
}

class _PokemonDetailsViewState extends State<PokemonDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          shadowColor: Color.fromARGB(0, 255, 255, 255),
          backgroundColor: Colors.red,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width * 1,
              child: PokemonSpriteContainer()),
        ));
  }
}

class PokemonSpriteContainer extends StatelessWidget {
  const PokemonSpriteContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80), topRight: Radius.circular(80))),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200, // Set the width as needed
              height: 200, // Set the height as needed
              child: Image.network(
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/252.png'),
            )
          ],
        ));
  }
}
