// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokedex/pokedex.dart';

class PokemonSpeciesController {
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

  Future<dynamic> fetchPokemonSpeciesData(String name) async {
    final pokemon = await Pokedex().pokemonSpecies.get(name: name);

    final int pokemonId = pokemon.id;
    final String pokemonName = pokemon.name;
    final pokemonGenderRate = pokemon.genderRate;
    final pokemonColor = pokemon.color.name;
    final pokemonHabitat = pokemon.habitat?.name;
    final pokemonBaseHappiness = pokemon.baseHappiness;
    final pokemonCatchRate = pokemon.captureRate;
    final pokemonHatchCounter = pokemon.hatchCounter;
    final pokemonShape = pokemon.shape?.name;

    final List<dynamic> flavorTextEntries = pokemon.flavorTextEntries;
    String? pokemonDesiredFlavorText, pokemonDesiredGenera;
    final List<dynamic> genera = pokemon.genera;

    for (final entry in genera) {
      if (entry.language?.name == 'en') {
        pokemonDesiredGenera = entry.genus;
        break;
      }
    }

    for (final entry in flavorTextEntries) {
      if (entry.language?.name == 'en' && entry.version?.name == 'emerald') {
        pokemonDesiredFlavorText = entry.flavorText;
        break; // Stop iterating once the desired entry is found
      }
    }

    return {
      'pokemon': pokemon,
      'pokemonId': pokemonId,
      'pokemonName': pokemonName,
      'pokemonGenderRate': pokemonGenderRate,
      'pokemonColor': pokemonColor,
      'pokemonHabitat': pokemonHabitat,
      'pokemonBaseHappiness': pokemonBaseHappiness,
      'pokemonCatchRate': pokemonCatchRate,
      'pokemonFlavorText': pokemonDesiredFlavorText,
      'pokemonGenera': pokemonDesiredGenera,
      'pokemonHatchCounter': pokemonHatchCounter,
      'pokemonShape': pokemonShape
    };
  }
}

// void main() async {
//   final PokemonSpeciesController controller = PokemonSpeciesController();

//   try {
//     final Map<String, dynamic> pokemonSpeciesData =
//         await controller.fetchPokemonSpeciesData('mudkip');
//     // Access the data you need from the returned map
//     debugPrint('Pokemon ID: ${pokemonSpeciesData['pokemonId']}');
//     debugPrint('Pokemon Name: ${pokemonSpeciesData['pokemonName']}');
//     debugPrint(
//         'Pokemon Gender Rate: ${pokemonSpeciesData['pokemonGenderRate']}');
//     debugPrint('Pokemon Color: ${pokemonSpeciesData['pokemonColor']}');
//     debugPrint('Pokemon Habitat: ${pokemonSpeciesData['pokemonHabitat']}');
//     debugPrint(
//         'Pokemon Base Happiness: ${pokemonSpeciesData['pokemonBaseHappiness']}');
//     debugPrint('Pokemon Catch Rate: ${pokemonSpeciesData['pokemonCatchRate']}');
//     debugPrint(
//         'Pokemon Flavor Text: ${pokemonSpeciesData['pokemonFlavorText']}');
//     debugPrint('Pokemon Genera: ${pokemonSpeciesData['pokemonHatchCounter']}');
//     debugPrint('Pokemon Genera: ${pokemonSpeciesData['pokemonGenera']}');
//     debugPrint('Pokemon Genera: ${pokemonSpeciesData['pokemonShape']}');
//   } catch (error) {
//     debugPrint('error fetching data: $error');
//   }
// }
