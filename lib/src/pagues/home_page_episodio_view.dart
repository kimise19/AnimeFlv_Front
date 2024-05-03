import 'package:flutter/material.dart';
import 'package:kaizen_anime/src/widgets/drawer_conten.dart';

class EpisodeDetails extends StatelessWidget {
  final String episodeUrl;

  const EpisodeDetails({Key? key, required this.episodeUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'URL del Episodio:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              episodeUrl,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
