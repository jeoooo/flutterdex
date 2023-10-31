// ignore_for_file: avoid_print, unused_import

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokedex/pokedex.dart';

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

class PokemonSpeciesController {
  Future<Map<String, dynamic>> fetchPokemonName(String name) async {
    final pokemon = await Pokedex().pokemonSpecies.get(name: name);
    final String pokemonName = pokemon.name;
    return {
      'pokemonName': pokemonName,
    };
  }

  Future<Map<String, dynamic>> fetchPokemonId(String name) async {
    final pokemon = await Pokedex().pokemonSpecies.get(name: name);
    final int pokemonId = pokemon.id;
    return {
      'pokemonId': pokemonId,
    };
  }

  Future<Map<String, dynamic>> fetchPokemonGenderRate(String name) async {
    final pokemon = await Pokedex().pokemonSpecies.get(name: name);
    final pokemonGenderRate = pokemon.genderRate;
    return {
      'genderRate': getGenderRatio(pokemonGenderRate) * 100,
    };
  }

  Future<Map<String, dynamic>> fetchPokemonColor(String name) async {
    final pokemon = await Pokedex().pokemonSpecies.get(name: name);
    final pokemonColor = pokemon.color.name;
    return {
      'pokemonColor': capitalize(pokemonColor),
    };
  }

  Future<Map<String, dynamic>> fetchPokemonHabitat(String name) async {
    final pokemon = await Pokedex().pokemonSpecies.get(name: name);
    final pokemonHabitat = pokemon.habitat?.name;
    return {
      'pokemonHabitat': capitalize(pokemonHabitat.toString()),
    };
  }

  Future<Map<String, dynamic>> fetchPokemonGenderRatioString(
      String name) async {
    final pokemon = await Pokedex().pokemonSpecies.get(name: name);
    final pokemonGenderRate = pokemon.genderRate;
    return {
      'pokemonGenderRatioString':
          getGenderRatioString(getGenderRatio(pokemonGenderRate))
    };
  }

  Future<Map<String, dynamic>> fetchPokemonBaseHappiness(String name) async {
    final pokemon = await Pokedex().pokemonSpecies.get(name: name);

    final pokemonBaseHappiness = pokemon.baseHappiness;
    return {
      'pokemonBaseHappiness': pokemonBaseHappiness,
    };
  }

  Future<Map<String, dynamic>> fetchPokemonCaptureRate(String name) async {
    final pokemon = await Pokedex().pokemonSpecies.get(name: name);
    final pokemonCatchRate = pokemon.captureRate;
    return {
      'pokemonCatchRate': pokemonCatchRate,
    };
  }

  Future<Map<String, dynamic>> fetchPokemonHatchRate(String name) async {
    final pokemon = await Pokedex().pokemonSpecies.get(name: name);
    final pokemonHatchCounter = pokemon.hatchCounter;
    return {
      'pokemonHatchCounter': pokemonHatchCounter,
    };
  }

  Future<Map<String, dynamic>> fetchPokemonShape(String name) async {
    final pokemon = await Pokedex().pokemonSpecies.get(name: name);

    final pokemonShape = pokemon.shape?.name;
    return {'pokemonShape': capitalize(pokemonShape.toString())};
  }

  Future<Map<String, dynamic>> fetchPokemonFlavorText(String name) async {
    final pokemon = await Pokedex().pokemonSpecies.get(name: name);

    final List<dynamic> flavorTextEntries = pokemon.flavorTextEntries;
    String? pokemonDesiredFlavorText;
    for (final entry in flavorTextEntries) {
      if (entry.language?.name == 'en' && entry.version?.name == 'emerald') {
        pokemonDesiredFlavorText = entry.flavorText;
        break; // Stop iterating once the desired entry is found
      }
    }

    return {
      'pokemonFlavorText': pokemonDesiredFlavorText,
    };
  }

  Future<Map<String, dynamic>> fetchPokemonGenera(String name) async {
    final pokemon = await Pokedex().pokemonSpecies.get(name: name);

    String? pokemonDesiredGenera;
    final List<dynamic> genera = pokemon.genera;

    for (final entry in genera) {
      if (entry.language?.name == 'en') {
        pokemonDesiredGenera = entry.genus;
        break;
      }
    }

    return {
      'pokemonGenera': pokemonDesiredGenera,
    };
  }
}

// void main() async {
//   final PokemonSpeciesController controller = PokemonSpeciesController();

//   try {
//     final String pokemonName = 'mudkip';

//     final Map<String, dynamic> pokemonSpeciesData = {
//       'pokemonId': await controller.fetchPokemonId(pokemonName),
//       'pokemonName': await controller.fetchPokemonName(pokemonName),
//       'pokemonGenderRate': await controller.fetchPokemonGenderRate(pokemonName),
//       'pokemonColor': await controller.fetchPokemonColor(pokemonName),
//       'pokemonHabitat': await controller.fetchPokemonHabitat(pokemonName),
//       'pokemonBaseHappiness':
//           await controller.fetchPokemonBaseHappiness(pokemonName),
//       'pokemonCatchRate': await controller.fetchPokemonCaptureRate(pokemonName),
//       'pokemonHatchCounter':
//           await controller.fetchPokemonHatchRate(pokemonName),
//       'pokemonShape': await controller.fetchPokemonShape(pokemonName),
//       'pokemonFlavorText': await controller.fetchPokemonFlavorText(pokemonName),
//       'pokemonGenera': await controller.fetchPokemonGenera(pokemonName),
//     };

//     // Access the data you need from the returned map
//     debugPrint('Pokemon ID: ${pokemonSpeciesData['pokemonId']}');
//     debugPrint(
//         'Pokemon Name: ${pokemonSpeciesData['pokemonName']['pokemonName']}');
//     debugPrint(
//         'Pokemon Gender Rate: ${pokemonSpeciesData['pokemonGenderRate']['genderRate']}');
//     debugPrint(
//         'Pokemon Color: ${pokemonSpeciesData['pokemonColor']['pokemonColor']}');
//     debugPrint(
//         'Pokemon Habitat: ${pokemonSpeciesData['pokemonHabitat']['pokemonHabitat']}');
//     debugPrint(
//         'Pokemon Base Happiness: ${pokemonSpeciesData['pokemonBaseHappiness']['pokemonBaseHappiness']}');
//     debugPrint(
//         'Pokemon Catch Rate: ${pokemonSpeciesData['pokemonCatchRate']['pokemonCatchRate']}');
//     debugPrint(
//         'Pokemon Hatch Counter: ${pokemonSpeciesData['pokemonHatchCounter']['pokemonHatchCounter']}');
//     debugPrint(
//         'Pokemon Shape: ${pokemonSpeciesData['pokemonShape']['pokemonShape']}');
//     debugPrint(
//         'Pokemon Flavor Text: ${pokemonSpeciesData['pokemonFlavorText']['pokemonFlavorText']}');
//     debugPrint(
//         'Pokemon Genera: ${pokemonSpeciesData['pokemonGenera']['pokemonGenera']}');
//   } catch (error) {
//     debugPrint('error fetching data: $error');
//   }
// }
