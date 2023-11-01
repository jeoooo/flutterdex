// ignore_for_file: prefer_const_constructors, avoid_print, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutterdex/controllers/pokemon_controller.dart';
import 'package:flutterdex/controllers/pokemonlist_controller.dart';
import 'package:flutterdex/models/pokemonlist_model.dart';
import 'package:flutterdex/utils/string_extension.dart';
import 'package:flutterdex/views/pokemon_details_view.dart';

import 'widgets/loading.dart';
import 'widgets/pokemon_card.dart';

int extractPokemonSpeciesId(String url) {
  final regex = RegExp(r'/(\d+)/$');
  final match = regex.firstMatch(url);

  if (match != null && match.groupCount >= 1) {
    return int.parse(match.group(1)!);
  } else {
    throw Exception('Invalid Pokemon species URL');
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<PokemonList> _pokemonList;
  final Map<String, dynamic> _pokemonTypeCache = {};

  @override
  void initState() {
    super.initState();
    // 'https://pokeapi.co/api/v2/pokemon-species/?offset=251&limit=135'
    // testing deoxys
    // 'https://pokeapi.co/api/v2/pokemon-species/?offset=380&limit=6'
    _pokemonList = PokemonListController().fetchPokemonList(251, 135);
  }

  // ignore: unused_element
  Future<dynamic> _getPokemonTypes(String pokemonName) async {
    // Check the cache first
    if (_pokemonTypeCache.containsKey(pokemonName)) {
      return _pokemonTypeCache[pokemonName];
    }

    // If not in the cache, fetch from the API
    dynamic pokemonTypes =
        await PokemonController().fetchPokemonTypes(pokemonName);

    // Store in the cache
    _pokemonTypeCache[pokemonName] = pokemonTypes;

    return pokemonTypes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        shadowColor: Color(0x00ff8080),
        backgroundColor: Colors.red,
        title: Text('Flutterdex'),
      ),
      body: FutureBuilder(
        future: _pokemonList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.results?.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: PokemonController().fetchPokemonTypes(
                    snapshot.data!.results![index].name.toString(),
                  ),
                  builder: (context, pokemonTypesSnapshot) {
                    if (pokemonTypesSnapshot.hasData) {
                      dynamic pokemontypes = pokemonTypesSnapshot.data;
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PokemonDetailsView(
                                pokemonId: extractPokemonSpeciesId(
                                  snapshot.data!.results![index].url.toString(),
                                ),
                                pokemonName: snapshot.data!.results![index].name
                                    .toString()
                                    .capitalize(),
                                type1: pokemontypes['pokemonType1'],
                                typeColor1: pokemontypes['typeColor1'],
                                type2: pokemontypes['pokemonType2'],
                                typeColor2: pokemontypes['typeColor2'],
                                pokemon: '',
                              ),
                            ),
                          );
                        },
                        child: PokemonCard(
                          type1: pokemontypes['pokemonType1'],
                          typeColor1: pokemontypes['typeColor1'],
                          // Fix: Use 'type2' and 'typeColor2' instead of 'typeColor1'
                          type2: pokemontypes['pokemonType2'],
                          typeColor2: pokemontypes['typeColor2'],
                          pokemonId: extractPokemonSpeciesId(
                            snapshot.data!.results![index].url.toString(),
                          ),
                          pokemonName: snapshot.data!.results![index].name
                              .toString()
                              .capitalize(),
                        ),
                      );
                    } else if (pokemonTypesSnapshot.hasError) {
                      return Center(
                        child: Text('${pokemonTypesSnapshot.error}'),
                      );
                    }
                    return Loading();
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return Loading();
        },
      ),
    );
  }
}
