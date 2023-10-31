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

String hectogramsToKilograms(int hectograms) {
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
  Future<Map<String, dynamic>> fetchPokemonId(String name) async {
    final pokemon = await Pokedex().pokemon.get(name: name);
    final int pokemonId = pokemon.id;
    return {
      'pokemonId': pokemonId,
    };
  }

  Future<Map<String, dynamic>> fetchPokemonName(String name) async {
    final pokemon = await Pokedex().pokemon.get(name: name);
    final String pokemonName = pokemon.name;
    return {
      'pokemonName': capitalize(pokemonName),
    };
  }

  Future<Map<String, dynamic>> fetchPokemonAbility(String name) async {
    final pokemon = await Pokedex().pokemon.get(name: name);

    final pokemonAbility = pokemon.abilities[0].ability.name;
    final ability = await Pokedex().abilities.get(name: pokemonAbility);
    final dynamic abilityEffectEntries = ability.effectEntries[0].effect;

    final dynamic abilityFlavorTextEntries =
        ability.flavorTextEntries[1].flavorText;
    return {
      'pokemonAbility': capitalize(pokemonAbility),
      'pokemonAbilityEffectEntries': abilityEffectEntries,
      'pokemonAbilityFlavorTextEntries': abilityFlavorTextEntries,
    };
  }

  Future<Map<String, dynamic>> fetchPokemonHeightWeight(String name) async {
    final pokemon = await Pokedex().pokemon.get(name: name);

    final pokemonHeight = pokemon.height;
    final pokemonWeight = pokemon.weight;

    return {
      'pokemonHeight': pokemonHeight,
      'pokemonWeight': pokemonWeight,
    };
  }

  Future<Map<String, dynamic>> fetchPokemonSprites(String name) async {
    final pokemon = await Pokedex().pokemon.get(name: name);

    final int pokemonId = pokemon.id;

    final pokemonSpriteFrontDefault =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png';
    final pokemonSpriteBackDefault =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/$pokemonId.png';
    final pokemonSpriteOffcialArtwork =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonId.png';

    return {
      'pokemonSpriteFrontDefault': pokemonSpriteFrontDefault,
      'pokemonSpriteBackDefault': pokemonSpriteBackDefault,
      'pokemonSpriteOffcialArtwork': pokemonSpriteOffcialArtwork,
    };
  }

  Future<Map<String, dynamic>> fetchPokemonStats(String name) async {
    final pokemon = await Pokedex().pokemon.get(name: name);

    final pokemonBaseExperience = pokemon.baseExperience;
    final hp = pokemon.stats[0].baseStat;
    final attack = pokemon.stats[1].baseStat;
    final defense = pokemon.stats[2].baseStat;
    final specialAttack = pokemon.stats[3].baseStat;
    final specialDefense = pokemon.stats[4].baseStat;

    return {
      'pokemonBaseExperience': pokemonBaseExperience,
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'specialAttack': specialAttack,
      'specialDefense': specialDefense,
    };
  }

  Future<Map<String, dynamic>> fetchPokemonTypes(String name) async {
    final pokemon = await Pokedex().pokemon.get(name: name);

    // Get the first type
    final pokemonType1 = pokemon.types[0].type.name;
    final Color typeColor1 = TypeColorMapper.getTypeColor(pokemonType1);
    debugPrint('Pokemon Type 1: $pokemonType1, Hex Code: $typeColor1');

    var pokemonType2 = 'No Second type';
    Color typeColor2 = const Color(0xFF808080); // Default color

    // Check if the Pokemon has a second type
    if (pokemon.types.length > 1) {
      pokemonType2 = pokemon.types[1].type.name;
      typeColor2 = TypeColorMapper.getTypeColor(pokemonType2);
      debugPrint('Pokemon Type 2: $pokemonType2, Hex Code: $typeColor2');
    }

    return {
      'pokemonType1': pokemonType1,
      'typeColor1': typeColor1,
      'pokemonType2': pokemonType2,
      'typeColor2': typeColor2,
    };
  }
}
//   Future<Map<String, dynamic>> fetchPokemonData(String name) async {
//     final pokemon = await Pokedex().pokemon.get(name: name);

//     final int pokemonId = pokemon.id;
//     final String pokemonName = pokemon.name;
//     final pokemonAbility = pokemon.abilities[0].ability.name;
//     final ability = await Pokedex().abilities.get(name: pokemonAbility);

//     final pokemonBaseExperience = pokemon.baseExperience;
//     final pokemonHeight = pokemon.height;
//     final pokemonWeight = pokemon.weight;
//     final pokemonSpriteFrontDefault =
//         'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png';
//     final pokemonSpriteBackDefault =
//         'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/$pokemonId.png';
//     final pokemonSpriteOffcialArtwork =
//         'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonId.png';

//     final dynamic abilityEffectEntries = ability.effectEntries[0].effect;
//     final dynamic abilityFlavorTextEntries =
//         ability.flavorTextEntries[1].flavorText;

//     // Get the first type
//     final pokemonType1 = pokemon.types[0].type.name;
//     final Color typeColor1 = TypeColorMapper.getTypeColor(pokemonType1);
//     debugPrint('Pokemon Type 1: $pokemonType1, Hex Code: $typeColor1');

//     var pokemonType2 = 'No Second type';
//     Color typeColor2 = const Color(0xFF808080); // Default color

//     // Check if the Pokemon has a second type
//     if (pokemon.types.length > 1) {
//       pokemonType2 = pokemon.types[1].type.name;
//       typeColor2 = TypeColorMapper.getTypeColor(pokemonType2);
//       debugPrint('Pokemon Type 2: $pokemonType2, Hex Code: $typeColor2');
//     }

//     final hp = pokemon.stats[0].baseStat;
//     final attack = pokemon.stats[1].baseStat;
//     final defense = pokemon.stats[2].baseStat;
//     final specialAttack = pokemon.stats[3].baseStat;
//     final specialDefense = pokemon.stats[4].baseStat;

//     return {
//       'pokemonId': pokemonId,
//       'pokemonName': capitalize(pokemonName),
//       'pokemonAbility': capitalize(pokemonAbility),
//       'pokemonAbilityEffectEntries': abilityEffectEntries,
//       'pokemonAbilityFlavorTextEntries': abilityFlavorTextEntries,
//       'pokemonBaseExperience': pokemonBaseExperience,
//       'pokemonHeight': pokemonHeight,
//       'pokemonWeight': pokemonWeight,
//       'pokemonSpriteFrontDefault': pokemonSpriteFrontDefault,
//       'pokemonSpriteBackDefault': pokemonSpriteBackDefault,
//       'pokemonSpriteOffcialArtwork': pokemonSpriteOffcialArtwork,
//       'pokemonType1': pokemonType1,
//       'typeColor1': typeColor1,
//       'pokemonType2': pokemonType2,
//       'typeColor2': typeColor2,
//       'hp': hp,
//       'attack': attack,
//       'defense': defense,
//       'specialAttack': specialAttack,
//       'specialDefense': specialDefense,
//     };
//   }
// }

// void main() async {
//   final PokemonController pokemonController = PokemonController();

//   try {
//     const String pokemonName = 'mudkip';

//     // Fetch Pokemon Details
//     final Map<String, dynamic> pokemonDetails = {
//       'pokemonId': await pokemonController.fetchPokemonId(pokemonName),
//       'pokemonName': await pokemonController.fetchPokemonName(pokemonName),
//       'pokemonAbility':
//           await pokemonController.fetchPokemonAbility(pokemonName),
//       'pokemonHeightWeight':
//           await pokemonController.fetchPokemonHeightWeight(pokemonName),
//       'pokemonSprites':
//           await pokemonController.fetchPokemonSprites(pokemonName),
//       'pokemonStats': await pokemonController.fetchPokemonStats(pokemonName),
//       'pokemonTypes': await pokemonController.fetchPokemonTypes(pokemonName),
//     };

//     debugPrint('\nPokemon Details:');
//     debugPrint('Pokemon ID: ${pokemonDetails['pokemonId']['pokemonId']}');
//     debugPrint('Pokemon Name: ${pokemonDetails['pokemonName']['pokemonName']}');
//     debugPrint(
//         'Pokemon Ability: ${pokemonDetails['pokemonAbility']['pokemonAbility']}');
//     debugPrint(
//         'Pokemon Height: ${pokemonDetails['pokemonHeightWeight']['pokemonHeight']}');
//     debugPrint(
//         'Pokemon Weight: ${pokemonDetails['pokemonHeightWeight']['pokemonWeight']}');
//     debugPrint(
//         'Pokemon Base Experience: ${pokemonDetails['pokemonStats']['pokemonBaseExperience']}');
//     debugPrint('Pokemon HP: ${pokemonDetails['pokemonStats']['hp']}');
//     debugPrint('Pokemon Attack: ${pokemonDetails['pokemonStats']['attack']}');
//     debugPrint('Pokemon Defense: ${pokemonDetails['pokemonStats']['defense']}');
//     debugPrint(
//         'Pokemon Special Attack: ${pokemonDetails['pokemonStats']['specialAttack']}');
//     debugPrint(
//         'Pokemon Special Defense: ${pokemonDetails['pokemonStats']['specialDefense']}');
//     debugPrint(
//         'Pokemon Type 1: ${pokemonDetails['pokemonTypes']['pokemonType1']}');
//     debugPrint(
//         'Pokemon Type 2: ${pokemonDetails['pokemonTypes']['pokemonType2']}');
//     debugPrint('Type 1 Color: ${pokemonDetails['pokemonTypes']['typeColor1']}');
//     debugPrint('Type 2 Color: ${pokemonDetails['pokemonTypes']['typeColor2']}');
//   } catch (error) {
//     debugPrint('Error fetching data: $error');
//   }
// }
