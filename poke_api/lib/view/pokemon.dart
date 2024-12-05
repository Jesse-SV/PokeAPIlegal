import 'package:flutter/material.dart';
import 'package:pokeapi/common/functions.dart';

class Pokemon extends StatelessWidget {
  final Map<String, dynamic> pokemonData;
  const Pokemon({required this.pokemonData});

  @override
  Widget build(BuildContext context) {
    int generation;

    if (pokemonData['id'] >= 1 && pokemonData['id'] <= 151) {
      generation = 1;
    } else if (pokemonData['id'] >= 152 && pokemonData['id'] <= 251) {
      generation = 2;
    } else if (pokemonData['id'] >= 252 && pokemonData['id'] <= 386) {
      generation = 3;
    } else if (pokemonData['id'] >= 387 && pokemonData['id'] <= 493) {
      generation = 4;
    } else if (pokemonData['id'] >= 494 && pokemonData['id'] <= 649) {
      generation = 5;
    } else if (pokemonData['id'] >= 650 && pokemonData['id'] <= 721) {
      generation = 6;
    } else if (pokemonData['id'] >= 722 && pokemonData['id'] <= 809) {
      generation = 7;
    } else if (pokemonData['id'] >= 810 && pokemonData['id'] <= 898) {
      generation = 8;
    } else if (pokemonData['id'] >= 899 && pokemonData['id'] <= 1008) {
      generation = 9;
    } else {
      generation = -1;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pokemonData['name'],
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1.0,
            height: MediaQuery.of(context).size.height * 0.40,
            decoration: BoxDecoration(
              color: getTypeColor(pokemonData['types'][0]['type']['name']),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: MediaQuery.of(context).size.width * 0.15,
                  child: Image.network(
                    pokemonData['sprites']['front_default'],
                    width: MediaQuery.of(context).size.width * 0.7,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: MediaQuery.of(context).size.width * 0.05,
                  child: Text(
                    pokemonData['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Info",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Types: ${pokemonData['types'][0]['type']['name']}${pokemonData['types'].length > 1 ? " / ${pokemonData['types'][1]['type']['name']}" : ""}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Altura: ${pokemonData['height'] / 10} M',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Peso: ${pokemonData['weight'] / 10} KG',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Número na PokeDéx: ${pokemonData['id']}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Geração: $generation',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
