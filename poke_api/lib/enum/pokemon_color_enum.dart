import 'package:flutter/material.dart';

enum PokemonType {
  fire,
  water,
  grass,
  electric,
  psychic,
  bug,
  normal,
  fairy,
  ghost,
  dragon,
  dark,
  ice,
  fighting,
  rock,
  ground,
  steel,
  poison,
}

extension PokemonTypeExtension on PokemonType {
  Color get color {
    switch (this) {
      case PokemonType.fire:
        return const Color.fromARGB(255, 255, 97, 85);
      case PokemonType.water:
        return const Color.fromARGB(255, 88, 180, 255);
      case PokemonType.grass:
        return const Color.fromARGB(255, 138, 255, 142);
      case PokemonType.electric:
        return const Color.fromARGB(255, 255, 243, 136);
      case PokemonType.psychic:
        return const Color.fromARGB(255, 182, 92, 198);
      case PokemonType.bug:
        return const Color.fromARGB(255, 141, 191, 68);
      case PokemonType.normal:
        return const Color.fromARGB(255, 176, 176, 176);
      case PokemonType.fairy:
        return const Color.fromARGB(255, 255, 107, 157);
      case PokemonType.ghost:
        return const Color.fromARGB(255, 222, 158, 234);
      case PokemonType.dragon:
        return const Color.fromARGB(255, 131, 194, 245);
      case PokemonType.dark:
        return const Color.fromARGB(255, 47, 133, 155);
      case PokemonType.ice:
        return const Color.fromARGB(255, 178, 215, 242);
      case PokemonType.fighting:
        return const Color.fromARGB(255, 184, 78, 69);
      case PokemonType.rock:
        return const Color.fromARGB(255, 183, 114, 89);
      case PokemonType.ground:
        return const Color.fromARGB(255, 172, 146, 136);
      case PokemonType.steel:
        return const Color.fromARGB(255, 159, 159, 159);
      case PokemonType.poison:
        return const Color.fromARGB(255, 164, 123, 244);
      default:
        return const Color.fromARGB(255, 164, 164, 164);
    }
  }
}
