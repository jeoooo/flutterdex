// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
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

String decimetersToMeters(int decimeters) {
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

class TypeColorMapper {
  static Map<String, Color> typeColors = {
    'normal': const Color(0xFFA8A77A),
    'fire': const Color(0xFFEE8130),
    'water': const Color(0xFF6390F0),
    'electric': const Color(0xFFF7D02C),
    'grass': const Color(0xFF7AC74C),
    'ice': const Color(0xFF96D9D6),
    'fighting': const Color(0xFFC22E28),
    'poison': const Color(0xFFA33EA1),
    'ground': const Color(0xFFE2BF65),
    'flying': const Color(0xFFA98FF3),
    'psychic': const Color(0xFFF95587),
    'bug': const Color(0xFFA6B91A),
    'rock': const Color(0xFFB6A136),
    'ghost': const Color(0xFF735797),
    'dragon': const Color(0xFF6F35FC),
    'dark': const Color(0xFF705746),
    'steel': const Color(0xFFB7B7CE),
    'fairy': const Color(0xFFD685AD),
  };

  static Color getTypeColor(String type) {
    // Replace with your logic to get type color based on the context
    // You can use Theme.of(context).accentColor or any other method
    return typeColors[type.toLowerCase()] ?? Colors.grey;
  }

  static List<Color> getTypesColors(List<dynamic> types, BuildContext context) {
    return types
        .map<Color>((type) => getTypeColor(type['type']['name']))
        .toList();
  }
}

class PokemonController {
  Future<Map<String, dynamic>> fetchPokemonData(String name) async {
    if (name == 'deoxys') {
      final pokemon = await Pokedex().pokemon.get(name: name);

      const int pokemonId = 386;
      const String pokemonName = 'Deoxys';
      final pokemonAbility = pokemon.abilities[0].ability.name;
      final pokemonBaseExperience = pokemon.baseExperience;
      final pokemonHeight = pokemon.height;
      final pokemonWeight = pokemon.weight;
      const pokemonSpriteFrontDefault =
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png';
      const pokemonSpriteBackDefault =
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/$pokemonId.png';
      const pokemonSpriteOffcialArtwork =
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonId.png';

      // Get the first type
      final pokemonType1 = pokemon.types[0].type.name;
      final Color typeColor1 = TypeColorMapper.getTypeColor(pokemonType1);
      debugPrint('Pokemon Type 1: $pokemonType1, Hex Code: $typeColor1');

      // Check if the Pokemon has a second type
      if (pokemon.types.length > 1) {
        final pokemonType2 = pokemon.types[1].type.name;
        final Color typeColor2 = TypeColorMapper.getTypeColor(pokemonType2);
        debugPrint('Pokemon Type 2: $pokemonType2, Hex Code: $typeColor2');
      }

      return {
        'pokemonId': pokemonId,
        'pokemonName': pokemonName,
        'pokemonAbility': pokemonAbility,
        'pokemonBaseExperience': pokemonBaseExperience,
        'pokemonHeight': pokemonHeight,
        'pokemonWeight': pokemonWeight,
        'pokemonSpriteFrontDefault': pokemonSpriteFrontDefault,
        'pokemonSpriteBackDefault': pokemonSpriteBackDefault,
        'pokemonSpriteOffcialArtwork': pokemonSpriteOffcialArtwork,
        // Add more data as needed...
      };
    } else {
      final pokemon = await Pokedex().pokemon.get(name: name);

      final int pokemonId = pokemon.id;
      final String pokemonName = pokemon.name;
      final pokemonAbility = pokemon.abilities[0].ability.name;
      final pokemonBaseExperience = pokemon.baseExperience;
      final pokemonHeight = pokemon.height;
      final pokemonWeight = pokemon.weight;
      final pokemonSpriteFrontDefault =
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png';
      final pokemonSpriteBackDefault =
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/$pokemonId.png';
      final pokemonSpriteOffcialArtwork =
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonId.png';

      // Get the first type
      final pokemonType1 = pokemon.types[0].type.name;
      final Color typeColor1 = TypeColorMapper.getTypeColor(pokemonType1);
      debugPrint('Pokemon Type 1: $pokemonType1, Hex Code: $typeColor1');

      // Check if the Pokemon has a second type
      if (pokemon.types.length > 1) {
        final pokemonType2 = pokemon.types[1].type.name;
        final Color typeColor2 = TypeColorMapper.getTypeColor(pokemonType2);
        debugPrint('Pokemon Type 2: $pokemonType2, Hex Code: $typeColor2');
      }

      return {
        'pokemonId': pokemonId,
        'pokemonName': pokemonName,
        'pokemonAbility': pokemonAbility,
        'pokemonBaseExperience': pokemonBaseExperience,
        'pokemonHeight': pokemonHeight,
        'pokemonWeight': pokemonWeight,
        'pokemonSpriteFrontDefault': pokemonSpriteFrontDefault,
        'pokemonSpriteBackDefault': pokemonSpriteBackDefault,
        'pokemonSpriteOffcialArtwork': pokemonSpriteOffcialArtwork,
        // Add more data as needed...
      };
    }
  }
}

void main() async {
  try {
    final PokemonController pokemonController = PokemonController();
    final Map<String, dynamic> pokemonData =
        await pokemonController.fetchPokemonData('deoxys-normal');

    // Print the information
    debugPrint('Pokemon ID: ${pokemonData['pokemonId']}');
    debugPrint('Pokemon Name: ${pokemonData['pokemonName']}');
    debugPrint('Pokemon Ability: ${pokemonData['pokemonAbility']}');
    debugPrint(
        'Pokemon Base Experience: ${pokemonData['pokemonBaseExperience']}');
    debugPrint('Pokemon Height: ${pokemonData['pokemonHeight']}');
    debugPrint('Pokemon Weight: ${pokemonData['pokemonWeight']}');
    // Add more prints as needed...

    // For types
    if (pokemonData.containsKey('pokemonType1')) {
      debugPrint('Pokemon Type 1: ${pokemonData['pokemonType1']}');
      debugPrint('Type Color 1: ${pokemonData['typeColor1']}');
    }

    if (pokemonData.containsKey('pokemonType2')) {
      debugPrint('Pokemon Type 2: ${pokemonData['pokemonType2']}');
      debugPrint('Type Color 2: ${pokemonData['typeColor2']}');
    }
    debugPrint(
        'Sprite (Front Default): ${pokemonData['pokemonSpriteFrontDefault']}');
    debugPrint(
        'Sprite (Front Default): ${pokemonData['pokemonSpriteBackDefault']}');
  } catch (error) {
    debugPrint('Error fetching Pokemon data: $error');
  }
}
