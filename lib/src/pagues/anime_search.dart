import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kaizen_anime/src/pagues/anime_detail.dart';
import 'package:kaizen_anime/src/widgets/drawer_conten.dart';

class AnimeSearchPage extends StatefulWidget {
  const AnimeSearchPage({Key? key}) : super(key: key);

  @override
  State<AnimeSearchPage> createState() => _AnimeSearchPageState();
}

class _AnimeSearchPageState extends State<AnimeSearchPage> {
  late TextEditingController _searchController;
  List<dynamic> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void searchAnime(String query) async {
    String apiUrl =
        "http://192.168.0.108:4000/search?url=https://www3.animeflv.net/browse?q=$query";
    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _searchResults = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Fondo negro
      child: Scaffold(
        drawer: AppDrawer(),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 250,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      searchAnime(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Buscar anime...',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Container(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          "Lista completa de Animes",
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      )),
                ),
                Wrap(
                  spacing: 35.0, // Espacio entre las imágenes
                  runSpacing: 20.0, // Espacio entre las filas de imágenes
                  children: _searchResults.map<Widget>((result) {
                    return _buildItem(result);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(Map<String, dynamic> result) {
    return GestureDetector(
      onTap: () {
        String url = result['url'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimeDetails(animeUrl: url),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: 150.0,
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(result['url_imagen']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Color.fromARGB(255, 241, 97, 0),
                  child: Text(
                    result['tipo'],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
            width: 150.0, // Ancho máximo del contenedor
            child: Text(
              result['titulo'],
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
