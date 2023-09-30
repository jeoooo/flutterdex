import 'package:flutterdex/data/models/pokemon_list_model.dart';
import 'package:flutterdex/data/services/pokemon_api_service.dart';

import 'package:flutter/foundation.dart';

/// A view model class that provides functionality to retrieve a list of Pokemon species.
class PokemonListViewModel {
  final PokemonApiService _pokemonApiService = PokemonApiService();

  /// * Fetches all the Pokemon from the API and returns a [PokemonList] object.
  ///
  /// ? Returns a [Future] that completes with a [PokemonList] object.
  /// ! Throws an error if the API call fails.
  Future<PokemonList> getAllPokemon() async {
    try {
      final pokemonList = await _pokemonApiService.getAllPokemon();
      return PokemonList.fromJson({'results': pokemonList});
    } catch (e) {
      debugPrint('Error occurred while fetching pokemon list: $e');
      rethrow;
    }
  }
}
