// ignore_for_file: prefer_const_constructors, avoid_print, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutterdex/controllers/pokemonlist_controller.dart';
import 'package:flutterdex/models/pokemonlist_model.dart';
import 'package:flutterdex/views/pokemon_details_view.dart';

String capitalize(String s) {
  if (s.isEmpty) {
    return s;
  }
  return s[0].toUpperCase() + s.substring(1);
}

int extractPokemonSpeciesId(String url) {
  final regex = RegExp(r'/(\d+)/$');
  final match = regex.firstMatch(url);
  if (match != null) {
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

  @override
  void initState() {
    super.initState();
    _pokemonList = PokemonListController().fetchPokemonList();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutterdex'),
      ),
      body: PokemonCard(),
    );
  }

  FutureBuilder<PokemonList> PokemonCard() {
    return FutureBuilder<PokemonList>(
      future: _pokemonList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Display the Pokemon list data
          return ListView.builder(
            itemCount: snapshot.data!.results?.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PokemonDetailsView(
                          pokemon:
                              snapshot.data!.results![index].name.toString()),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Row(
                    children: [
                      SizedBox(width: 30),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              '#${extractPokemonSpeciesId(snapshot.data!.results![index].url.toString()).toString()}',
                              style: TextStyle(
                                  fontSize: 24, fontFamily: 'Pokemon-Emerald'),
                            ),
                            SizedBox(width: 10),
                            Text(
                              capitalize(snapshot.data!.results![index].name
                                  .toString()),
                              style: TextStyle(
                                  fontSize: 24, fontFamily: 'Pokemon-Emerald'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Image.network(
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${extractPokemonSpeciesId(snapshot.data!.results![index].url.toString())}.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          // Display an error message
          return Text('${snapshot.error}');
        }
        // Display a loading spinner
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
