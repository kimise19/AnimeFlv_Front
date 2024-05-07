import 'package:flutter/material.dart';
import 'package:kaizen_anime/src/pagues/video_player_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EpisodeDetailsStreamwish extends StatefulWidget {
  final int chapterNumber;
  final String chapterUrl;

  const EpisodeDetailsStreamwish(
      {Key? key, required this.chapterNumber, required this.chapterUrl})
      : super(key: key);

  @override
  State<EpisodeDetailsStreamwish> createState() =>
      _EpisodeDetailsStreamwishState();
}

class _EpisodeDetailsStreamwishState extends State<EpisodeDetailsStreamwish> {
  late Future<String> _episodeData;
  String? _streamWishUrl;

  @override
  void initState() {
    super.initState();
    _episodeData = fetchEpisodeData();
  }

  Future<String> fetchEpisodeData() async {
    final response = await http.get(Uri.parse(
        'http://192.168.0.108:4000/get_server_wish?url=https://www3.animeflv.net/ver/${widget.chapterUrl}-${widget.chapterNumber}'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final streamWishServers = jsonData['servers']['streamwish_servers'];
      if (streamWishServers.isNotEmpty) {
        // Obtener la primera URL de "streamwish_servers"
        _streamWishUrl = streamWishServers[0];
        // Redirigir automáticamente a la página de VideoPage y enviar la URL
        Future.delayed(Duration.zero, () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPage(url: _streamWishUrl!)),
          );
        });
        return _streamWishUrl!;
      } else {
        throw Exception('No se encontraron servidores de StreamWish');
      }
    } else {
      // Si la solicitud falla, lanza una excepción.
      throw Exception('Failed to load episode data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
      child: Center(
        child: FutureBuilder<String>(
          future: _episodeData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              // Si la solicitud se completa con éxito, muestra la URL.
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('URL del servidor de StreamWish:'),
                  SizedBox(height: 10),
                  Text(snapshot.data!),
                ],
              );
            } else if (snapshot.hasError) {
              // Si la solicitud falla, muestra un mensaje de error.
              return Text('Error: ${snapshot.error}');
            }
            // Por defecto, muestra un indicador de carga.
            return CircularProgressIndicator();
          },
        ),
      ),
    ));
  }
}
