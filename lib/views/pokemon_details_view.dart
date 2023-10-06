// ignore_for_file: avoid_print, prefer_const_constructors

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

class PokemonDetailsView extends StatefulWidget {
  final String pokemon;
  const PokemonDetailsView({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<PokemonDetailsView> createState() => _PokemonDetailsViewState();
}

class _PokemonDetailsViewState extends State<PokemonDetailsView> {
  Future<dynamic> getPokemonData(String name) async {
    if (name == 'deoxys') {
      name = 'deoxys-normal';
      final response = await Pokedex().pokemon.get(name: name);
      final flavor = await Pokedex().pokemonSpecies.get(name: 'deoxys');
      final ability = await Pokedex()
          .abilities
          .get(name: response.abilities[0].ability.name);
      return {'response': response, 'flavor': flavor, 'ability': ability};
    } else {
      final response = await Pokedex().pokemon.get(name: name);
      final flavor = await Pokedex().pokemonSpecies.get(name: name);
      final ability = await Pokedex()
          .abilities
          .get(name: response.abilities[0].ability.name);
      return {'response': response, 'flavor': flavor, 'ability': ability};
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentPageIndex = 0;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Flutterdex'),
        ),
        body: <dynamic>[
          PokemonInfo(),
          PokemonMoves(),
        ][currentPageIndex],
        bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
              print(index);
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.info_rounded),
              label: 'Info',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
          ],
        ));
  }

  Container PokemonMoves() {
    return Container(
      color: Colors.green,
      alignment: Alignment.center,
      child: const Text('Page 2'),
    );
  }

  SingleChildScrollView PokemonInfo() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    PokemonDetails(),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  NavigationBar bottomNavigationBar(int currentPageIndex) {
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      selectedIndex: currentPageIndex,
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.info_rounded),
          label: 'Info',
        ),
        NavigationDestination(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  FutureBuilder<dynamic> PokemonDetails() {
    return FutureBuilder<dynamic>(
        future: getPokemonData(widget.pokemon),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            final response = data['response'];
            final flavor = data['flavor'];
            final ability = data['ability'];
            return Column(
              children: [
                SizedBox(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.network(
                              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${response.id}.png',
                              height: 225,
                              width: 225,
                              fit: BoxFit.cover,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              color: Colors.white70,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                    '# ${response.id} ${capitalize(flavor.name)}',
                                                    style: const TextStyle(
                                                        fontSize: 40,
                                                        fontFamily:
                                                            'Pokemon-Emerald')),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            (Pokemon pokemon,
                                                PokemonSpecies pokemonSpecies) {
                                              final typeColors = {
                                                'normal':
                                                    const Color(0xffA8A77A),
                                                'fire': const Color(0xffEE8130),
                                                'water':
                                                    const Color(0xff6390F0),
                                                'electric':
                                                    const Color(0xffF7D02C),
                                                'grass':
                                                    const Color(0xff7AC74C),
                                                'ice': const Color(0xff96D9D6),
                                                'fighting':
                                                    const Color(0xffC22E28),
                                                'poison':
                                                    const Color(0xffA33EA1),
                                                'ground':
                                                    const Color(0xffE2BF65),
                                                'flying':
                                                    const Color(0xffA98FF3),
                                                'psychic':
                                                    const Color(0xffF95587),
                                                'bug': const Color(0xffA6B91A),
                                                'rock': const Color(0xffB6A136),
                                                'ghost':
                                                    const Color(0xff735797),
                                                'dragon':
                                                    const Color(0xff6F35FC),
                                                'dark': const Color(0xff705746),
                                                'steel':
                                                    const Color(0xffB7B7CE),
                                                'fairy':
                                                    const Color(0xffD685AD),
                                              };

                                              return Row(
                                                children: [
                                                  Card(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30))),
                                                    color: typeColors[pokemon
                                                            .types[0]
                                                            .type
                                                            .name] ??
                                                        Colors.grey,
                                                    child: SizedBox(
                                                      height: 30,
                                                      width: 100,
                                                      child: Center(
                                                        child: Text(
                                                            pokemon.types[0]
                                                                .type.name
                                                                .toUpperCase(),
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    'Pokemon-Emerald')),
                                                      ),
                                                    ),
                                                  ),
                                                  if (pokemon.types.length > 1)
                                                    const SizedBox(width: 8),
                                                  if (pokemon.types.length > 1)
                                                    Card(
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                                      color: typeColors[pokemon
                                                              .types[1]
                                                              .type
                                                              .name] ??
                                                          Colors.grey,
                                                      child: SizedBox(
                                                        height: 30,
                                                        width: 100,
                                                        child: Center(
                                                          child: Text(
                                                              pokemon.types[1]
                                                                  .type.name
                                                                  .toUpperCase(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      'Pokemon-Emerald')),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              );
                                            }(response, flavor),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                        '${hectogramsToKilograms(double.parse(response.weight.toString()))} kg',
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            fontFamily:
                                                                'Pokemon-Emerald')),
                                                    SizedBox(height: 8),
                                                    Text('Weight',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Pokemon-Emerald')),
                                                  ],
                                                ),
                                                SizedBox(width: 80),
                                                Column(
                                                  children: [
                                                    Text(
                                                        '${decimetersToMeters(double.parse(response.height.toString()))} m',
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            fontFamily:
                                                                'Pokemon-Emerald')),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      'Height',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Pokemon-Emerald'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Text('dex entry below'),
                                  SizedBox(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 300,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            color: Colors.white30,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    capitalize(ability.name),
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'Pokemon-Emerald'),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 400,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            color: Colors.white30,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    ability.flavorTextEntries[1]
                                                        .flavorText,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'Pokemon-Emerald'),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 400,
                                    child: Card(
                                      color: Colors.white30,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              flavor.flavorTextEntries[1]
                                                  .flavorText,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontFamily:
                                                      'Pokemon-Emerald'),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            print('snapshot has error: ${snapshot.error}');
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(child: const CircularProgressIndicator());
          }
        });
  }

  // ignore: non_constant_identifier_names
}
