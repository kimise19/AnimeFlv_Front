import 'package:flutter/material.dart';
import 'package:kaizen_anime/src/widgets/video_player_widget.dart';

class FilesPage extends StatelessWidget {
  final List<String> files;

  const FilesPage({Key? key, required this.files}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener dimensiones de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.black, // Fondo negro para evitar bordes blancos
      child: ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          // Calcular el ancho del contenedor para que se ajuste a la pantalla
          final containerWidth = screenWidth;

          return Container(
            width: containerWidth,
            child: AspectRatio(
              aspectRatio: 16 / 7.7, // 16:9 Aspect Ratio
              child: VideoPlayerWidget(videoUrl: files[index]),
            ),
          );
        },
      ),
    );
  }
}
