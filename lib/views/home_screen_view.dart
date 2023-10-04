// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';

final List<Map<String, dynamic>> pokemonList = [];

// https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/35.png

Future<void> getPokemon() async {
  Pokedex().pokemonSpecies.getPage(offset: 251, limit: 134).then((response) {
    final namedAPIResourceList = response;

    final List<NamedAPIResource> results = namedAPIResourceList.results;

    for (final namedAPIResource in results) {
      final name = toSentenceCase(namedAPIResource.name);
      final url = namedAPIResource.url;
      int pokemonId = extractPokemonId(url);
      String spriteurl =
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png';
      print(spriteurl);
      pokemonList.add({
        'name': name,
        'id': pokemonId,
        'sprite':
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonId.png'
      });
    }
  });
}

Future<void> getSpritebyId(int id) async {
  Pokedex().pokemon.get(id: id).then((response) {
    final namedAPIResource = response;

    final String? sprites = namedAPIResource.sprites.frontDefault;

    print(sprites);
  });
}

int extractPokemonId(String url) {
  RegExp regex = RegExp(r'/pokemon-species/(\d+)/');

  Match? match = regex.firstMatch(url);

  if (match != null) {
    String idString = match.group(1) ?? '';
    return int.tryParse(idString) ?? -1;
  } else {
    return -1;
  }
}

String toSentenceCase(String input) {
  if (input.isEmpty) {
    return input;
  }

  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon List'),
      ),
      body: FutureBuilder<void>(
          future: getPokemon(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: pokemonList.length,
                  itemBuilder: (context, index) {
                    final pokemon = pokemonList[index];
                    return Card(
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(pokemon['name']),
                              subtitle: Text('ID: ${pokemon['id']}'),
                            ),
                          ),
                          Image.network(
                            pokemon['sprite'],
                            width: 50.0,
                            height: 50.0,
                          )
                        ],
                      ),
                    );
                  });
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
