import 'package:flutterdex/data/models/pokemon_model.dart';
import 'package:flutterdex/data/services/pokemon_api_service.dart';
import 'package:flutter/foundation.dart';

/// A view model class that provides functionality to retrieve a list of Pokemon species.
class PokemonViewModel {
  final PokemonApiService _pokemonApiService = PokemonApiService();

  /// * Retrieves a Pokemon species with the given [id].
  ///
  /// ? Returns a [Future] that completes with a [Pokemon] object.
  /// ! Throws an error if the API call fails.
  Future<Pokemon> getPokemon(String id) async {
    try {
      final pokemonList = await _pokemonApiService.getPokemon(id);
      return Pokemon.fromJson({'results': pokemonList});
    } catch (e) {
      debugPrint('Error fetching Pokemon: $e');
      rethrow;
    }
  }
}