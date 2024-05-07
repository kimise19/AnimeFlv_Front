import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kaizen_anime/src/pagues/anime_page_episodio_view.dart';

class AnimeDetails extends StatefulWidget {
  final String animeUrl;

  const AnimeDetails({Key? key, required this.animeUrl}) : super(key: key);

  @override
  _AnimeDetailsState createState() => _AnimeDetailsState();
}

class _AnimeDetailsState extends State<AnimeDetails> {
  late Future<Map<String, dynamic>> _animeDetailsFuture;

  @override
  void initState() {
    super.initState();
    _animeDetailsFuture = fetchAnimeDetails(widget.animeUrl);
  }

  Future<Map<String, dynamic>> fetchAnimeDetails(String animeUrl) async {
    final response = await http
        .get(Uri.parse('http://192.168.0.108:4000/anime_data?url=$animeUrl'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load anime details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: _animeDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.black,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final animeDetails = snapshot.data!;
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      animeDetails['background_image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              animeDetails['image_src'],
                              width: 150,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 24),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    animeDetails['title'],
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    animeDetails['description_text'].isEmpty
                                        ? 'No disponible'
                                        : animeDetails['description_text'][0],
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        color: Colors.orange,
                                        child: Text(
                                          'Tipo: ${animeDetails['type']}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        color: Colors.blue,
                                        child: Text(
                                          'Puntuación: ${animeDetails['score']}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Capítulos',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 150,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                animeDetails['sucesion_numeros'].length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EpisodeDetailsStreamwish(
                                          chapterNumber:
                                              animeDetails['sucesion_numeros']
                                                  [index],
                                          chapterUrl: animeDetails['url'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            animeDetails['image_src'],
                                            width: 150,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Capítulo ${animeDetails['sucesion_numeros'][index]}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
