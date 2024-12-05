import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokeapi/common/functions.dart';
import 'package:pokeapi/service/pokeapi_service.dart';
import 'package:pokeapi/view/pokemon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PokeApiService _pokeApiService = PokeApiService();
  final ScrollController _scrollController = ScrollController();
  final int _limit = 20;
  List<dynamic> _pokemonList = [];
  bool _isLoading = true;
  bool _isFetchingMore = false;
  int _offset = 0;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadPokemonList();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadPokemonList() async {
    if (_isFetchingMore) return;
    _isFetchingMore = true;

    try {
      final data = await _pokeApiService.buscaListaPokemon(_limit, _offset);
      setState(() {
        _pokemonList.addAll(data['results']);
        _offset += _limit;
        _isLoading = false;
        _isFetchingMore = false;
      });
    } catch (e) {
      print(e);
      _isFetchingMore = false;
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadPokemonList();
    }
  }

  // Função de pesquisa
  Future<void> _searchPokemon(String query) async {
    _offset = 0;
    if (query.isEmpty) {
      setState(() {
        _pokemonList.clear();
        _isLoading = true;
      });
      _loadPokemonList();
    } else {
      final response = await _pokeApiService.buscaPokemon(query.toLowerCase());
      if (response != null) {
        setState(() {
          _pokemonList = [response];
          _isLoading = false;
        });
      } else {
        setState(() {
          _pokemonList = [];
          _isLoading = false;
        });
      }
    }
  }

  Widget buildPokemonCard(Map<String, dynamic> pokemon) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _pokeApiService.buscaPokemon(pokemon['name']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else {
          final pokemonData = snapshot.data!;
          final pokemonType = pokemonData['types'][0]['type']['name'];
          final pokemonId = pokemonData['id'];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Pokemon(pokemonData: pokemonData),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: getTypeColor(pokemonType),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Transform.rotate(
                    angle: 0.3,
                    child: Opacity(
                      opacity: 0.10,
                      child: Image.asset(
                        'assets/images/pokeball_dark.png',
                        height: 235,
                        width: 235,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Image.network(
                            pokemonData['sprites']['front_default'],
                            height: 140,
                            width: 140,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pokemon['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '#${pokemonId.toString().padLeft(3, '0')}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 195,
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Pokedex',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          // Imagem da pokebola
          Positioned(
            top: -(240 / 4.7),
            left: MediaQuery.of(context).size.width - (240 / 1.6),
            child: Opacity(
              child: Image.asset(
                'assets/images/pokeball_dark.png',
                height: 240,
                width: 240,
              ),
              opacity: 0.1,
            ),
          ),
          // Barra de pesquisa dentro do retângulo vermelho
          Positioned(
            top: 140, // Ajuste a posição vertical conforme necessário
            left: 16, // Ajuste a posição horizontal conforme necessário
            right: 16, // Ajuste a posição horizontal conforme necessário
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                onChanged: _searchPokemon, // Chama a função de pesquisa
                decoration: InputDecoration(
                  hintText: "Pesquisar...",
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          // Conteúdo da grid de pokemons
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: _pokemonList.length + (_isFetchingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _pokemonList.length) {
                        return Center(child: CircularProgressIndicator());
                      }
                      final pokemon = _pokemonList[index];
                      return buildPokemonCard(pokemon);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
