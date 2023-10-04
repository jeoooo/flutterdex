// ignore_for_file: avoid_print
import 'package:flutterdex/models/pokemonlist_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// offset=251&limit=135
class PokemonListController {
  final String apiUrl =
      'https://pokeapi.co/api/v2/pokemon-species/?offset=251&limit=135';

  Future<PokemonList> fetchPokemonList() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return PokemonList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Pokemon list');
    }
  }
}
