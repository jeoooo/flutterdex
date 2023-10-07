// ignore_for_file: avoid_print, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';

import 'package:percent_indicator/percent_indicator.dart';

import 'pokemon_moves_screen.dart';

// ! REFACTOR FUNCTIONS

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

      final pokemon = await Pokedex().pokemon.get(name: name);
      final pokemon_species =
          await Pokedex().pokemonSpecies.get(name: 'deoxys');
      final pokemon_ability = await Pokedex()
          .abilities
          .get(name: pokemon.abilities[0].ability.name);

      return {
        'pokemon': pokemon_species.name,
        'flavor_text_entry': pokemon_species.flavorTextEntries[2].flavorText,
        'ability_name': pokemon_ability.name,
        'ability_description': pokemon_ability.flavorTextEntries[1].flavorText,
        'gender_ratio': getGenderRatio(pokemon_species.genderRate),
      };
    } else {
      final pokemon = await Pokedex().pokemon.get(name: name);
      final pokemon_species = await Pokedex().pokemonSpecies.get(name: name);
      final pokemon_ability = await Pokedex()
          .abilities
          .get(name: pokemon.abilities[0].ability.name);

      return {
        'pokemon_id': pokemon.id,
        'pokemon_name': pokemon.name,
        'flavor_text_entry': pokemon_species.flavorTextEntries[2].flavorText,
        'ability_name': pokemon_ability.name,
        'ability_description': pokemon_ability.flavorTextEntries[1].flavorText,
        'gender_ratio': getGenderRatio(pokemon_species.genderRate),
        'pokemon_height': pokemon.height,
        'pokemon_weight': pokemon.weight,
        'pokemon_object': pokemon,
        'pokemon_species_object': pokemon_species
      };
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
          pokemon_moves_screen(),
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
        bottomNavigationState(currentPageIndex, index);
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

  void bottomNavigationState(int currentPageIndex, int index) {
    return setState(() {
      currentPageIndex = index;
    });
  }

  FutureBuilder<dynamic> PokemonDetails() {
    return FutureBuilder<dynamic>(
        future: getPokemonData(widget.pokemon),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            /*
        'pokemon': pokemon.name,
        'flavor_text_entry': pokemon_species.flavorTextEntries[2].flavorText,
        'ability_name': pokemon_ability.name,
        'ability_description': pokemon_ability.flavorTextEntries[1].flavorText,
        'gender_ratio': getGenderRatio(pokemon_species.genderRate),
        'pokemon_height': pokemon.height,
        'pokemon_weight': pokemon.weight,
        'pokemon_object': pokemon,
        'pokemon_species_object': pokemon_species
            */
            final data = snapshot.data!;
            final pokemon_id = data['pokemon_id'];
            final pokemon_name = data['pokemon_name'];
            final flavor_text_entry = data['flavor_text_entry'];
            final ability_name = data['ability_name'];
            final ability_description = data['ability_description'];
            final gender_ratio = data['gender_ratio'];
            final pokemon_height = data['pokemon_height'];
            final pokemon_weight = data['pokemon_weight'];
            final pokemon_object = data['pokemon_object'];
            final pokemon_species_object = data['pokemon_species_object'];
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
                              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemon_id.png',
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
                                                    '# $pokemon_id ${capitalize(pokemon_name)}',
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
                                                                    8))),
                                                    color: typeColors[
                                                            pokemon_object
                                                                .types[0]
                                                                .type
                                                                .name] ??
                                                        Colors.grey,
                                                    child: SizedBox(
                                                      height: 30,
                                                      width: 100,
                                                      child: Center(
                                                        child: Text(
                                                            pokemon_object
                                                                .types[0]
                                                                .type
                                                                .name
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
                                                  if (pokemon_object
                                                          .types.length >
                                                      1)
                                                    const SizedBox(width: 8),
                                                  if (pokemon_object
                                                          .types.length >
                                                      1)
                                                    Card(
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8))),
                                                      color: typeColors[
                                                              pokemon_object
                                                                  .types[1]
                                                                  .type
                                                                  .name] ??
                                                          Colors.grey,
                                                      child: SizedBox(
                                                        height: 30,
                                                        width: 100,
                                                        child: Center(
                                                          child: Text(
                                                              pokemon_object
                                                                  .types[1]
                                                                  .type
                                                                  .name
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
                                            }(pokemon_object,
                                                pokemon_species_object),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                        '${hectogramsToKilograms(double.parse(pokemon_weight.toString()))} kg',
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
                                                        '${decimetersToMeters(double.parse(pokemon_height.toString()))} m',
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
                                                    capitalize(ability_name),
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
                                                    ability_description,
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
                                              flavor_text_entry,
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
                                  SizedBox(
                                    width: 400,
                                    child: Card(
                                      color: Colors.white30,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                'Gender Ratio',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontFamily:
                                                        'Pokemon-Emerald'),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      getGenderRatioString(
                                                          gender_ratio),
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'Pokemon-Emerald')),
                                                ],
                                              ),
                                            ),
                                            if (getGenderRatioString(
                                                    gender_ratio) !=
                                                'Genderless')
                                              LinearPercentIndicator(
                                                // male #3355ff
                                                // female #ff77dd
                                                backgroundColor:
                                                    Color(0xffff77dd),
                                                progressColor:
                                                    Color(0xff3355ff),
                                                animation: true,
                                                lineHeight: 20.0,
                                                animationDuration: 2500,
                                                percent: gender_ratio,
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
            return const CircularProgressIndicator();
          }
        });
  }
}
