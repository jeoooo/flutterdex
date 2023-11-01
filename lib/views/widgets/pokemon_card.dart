// ignore_for_file: prefer_const_constructors, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutterdex/utils/string_extension.dart';

class PokemonCard extends StatelessWidget {
  final int pokemonId;
  final String pokemonName;
  final dynamic type1;
  final dynamic type2;
  final Color typeColor1;
  final Color typeColor2;

  const PokemonCard({
    Key? key,
    this.pokemonId = 25,
    this.pokemonName = 'pikachu',
    this.type1 = 'fighting',
    this.type2 = 'dragon',
    this.typeColor1 = const Color(0xff808080),
    this.typeColor2 = const Color(0xff808080),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width * 1,
      child: Card(
        color: Colors.white,
        // ignore: prefer_const_literals_to_create_immutables
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('#$pokemonId $pokemonName'),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Row(
                                children: [
                                  PokemonType(
                                    type: type1,
                                    typeColor: typeColor1,
                                  ),
                                  if (type2 != 'No Second type')
                                    PokemonType(
                                      type: type2,
                                      typeColor: typeColor2,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Place your Pokemon image widget here
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PokemonSprite(pokemonId: pokemonId),
            ),
          ],
        ),
      ),
    );
  }
}

class PokemonSprite extends StatelessWidget {
  const PokemonSprite({
    super.key,
    required this.pokemonId,
  });

  final int pokemonId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125, // Set the width as needed
      height: 125, // Set the height as needed
      child: Image.network(
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonId.png'), // Replace with the actual image source
    );
  }
}

class PokemonType extends StatelessWidget {
  const PokemonType({super.key, required this.type, required this.typeColor});

  final String type;
  final Color typeColor;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: typeColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            type.toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
}
