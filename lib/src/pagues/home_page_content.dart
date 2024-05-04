import 'package:flutter/material.dart';
import 'package:kaizen_anime/src/models/inital_page_model.dart';
import 'package:kaizen_anime/src/pagues/home_page_episodio_view.dart';
import 'package:kaizen_anime/src/services/inital_page_service.dart';
import 'package:kaizen_anime/src/widgets/custom_banner_ad.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  List<Episode> latestEpisodes = [];
  List<Anime> latestAnimes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final responseData = await ApiService.fetchInitialData();
      setState(() {
        latestEpisodes = (responseData['lastes_episodes'] as List)
            .map((e) => Episode.fromJson(e))
            .toList();
        latestAnimes = (responseData['latest_animes_add'] as List)
            .map((e) => Anime.fromJson(e))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.only(left: 50.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Textos a la izquierda
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text(
                          'Últimos episodios',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: latestEpisodes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                // Navegar a la pantalla de detalles del episodio
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EpisodeDetails(
                                      episodeUrl:
                                          latestEpisodes[index].episodeUrl,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 198,
                                          height: 138,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                width: 2),
                                          ),
                                          child: Image.network(
                                            latestEpisodes[index].imageUrl,
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            color:
                                                Color.fromARGB(255, 241, 97, 0),
                                            child: Text(
                                              latestEpisodes[index]
                                                  .episodeNumber,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Expanded(
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        child: Text(
                                          latestEpisodes[index].episodeTitle,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                15, // Tamaño del título igual al de la imagen
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text(
                          'Últimos animes agregados',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: latestAnimes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 200,
                                    child: Image.network(
                                      latestAnimes[index].imageUrl,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Expanded(
                                    child: Container(
                                      width: 150,
                                      child: Text(
                                        latestAnimes[index].title,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const CustomBannerAd()
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
