import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kaizen_anime/src/pagues/video_player.dart';

class VideoPage extends StatefulWidget {
  final String url;

  const VideoPage({Key? key, required this.url}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late Future<String> _videoPlayerData;
  late List<String> _files;

  @override
  void initState() {
    super.initState();
    _videoPlayerData = fetchVideoPlayerData();
    _files = [];
  }

  Future<String> fetchVideoPlayerData() async {
    final response = await http.get(Uri.parse(
        'http://192.168.0.108:4000/get_video_player?url=${widget.url}'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final files = jsonData['files'];
      if (files.isNotEmpty) {
        _files = List<String>.from(files);
        // Redirigir automáticamente a la página de FilesPage
        Future.delayed(Duration.zero, () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => FilesPage(files: _files)),
          );
        });
        return _files[0]; // Devolver el primer archivo como URL
      } else {
        throw Exception('No se encontraron archivos');
      }
    } else {
      throw Exception('Failed to load video player data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
      child: Center(
        child: FutureBuilder<String>(
          future: _videoPlayerData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              // No se mostrará nada aquí ya que se redirigirá a la página de FilesPage automáticamente
              return SizedBox.shrink();
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
