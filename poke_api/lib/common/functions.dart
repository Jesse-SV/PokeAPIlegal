import 'package:flutter/material.dart';
import 'package:pokeapi/enum/pokemon_color_enum.dart';

Color getTypeColor(String type) {
    switch (type) {
      case 'fire':
        return PokemonType.fire.color;
      case 'water':
        return PokemonType.water.color;
      case 'grass':
        return PokemonType.grass.color;
      case 'electric':
        return PokemonType.electric.color;
      case 'psychic':
        return PokemonType.psychic.color;
      case 'bug':
        return PokemonType.bug.color;
      case 'normal':
        return PokemonType.normal.color;
      case 'fairy':
        return PokemonType.fairy.color;
      case 'ghost':
        return PokemonType.ghost.color;
      case 'dragon':
        return PokemonType.dragon.color;
      case 'dark':
        return PokemonType.dark.color;
      case 'ice':
        return PokemonType.ice.color;
      case 'fighting':
        return PokemonType.fighting.color;
      case 'rock':
        return PokemonType.rock.color;
      case 'ground':
        return PokemonType.ground.color;
      case 'steel':
        return PokemonType.steel.color;
      case 'poison':
        return PokemonType.poison.color;
      default:
        return Colors.grey;
    }
  }