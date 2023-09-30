import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonApiService {
  /// ? The base URL for the PokeAPI's Pokemon Species endpoint.
  // ignore: constant_identifier_names
  static const String _POKEMON_SPECIES_URL =
      'https://pokeapi.co/api/v2/pokemon-species';
  // ignore: constant_identifier_names
  static const String _POKEMON_URL = 'https://pokeapi.co/api/v2/pokemon/';

  /// * Fetches a Pokemon from the API by its ID or name.
  ///
  /// ? Returns a [Map] containing the Pokemon's information.
  /// ! Throws an [Exception] if the request fails.

  Future<Map<String, dynamic>> getPokemon(String idOrName) async {
    final response = await http.get(Uri.parse('$_POKEMON_URL/$idOrName'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  /// * Fetches all the Pokemon from the API.
  /// ? Returns a list of maps containing the details of each Pokemon.
  /// ! Throws an exception if the API call fails.

  Future<List<Map<String, dynamic>>> getAllPokemon() async {
    final response =
        await http.get(Uri.parse('$_POKEMON_SPECIES_URL/?limit=10000'));
    if (response.statusCode == 200) {
      final results = json.decode(response.body)['results'] as List<dynamic>;
      return results.map((result) => result as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load pokemon');
    }
  }
}
