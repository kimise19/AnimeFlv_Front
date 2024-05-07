class Episode {
  final String episodeNumber;
  final String episodeTitle;
  final String episodeUrl;
  final String imageUrl;

  Episode({
    required this.episodeNumber,
    required this.episodeTitle,
    required this.episodeUrl,
    required this.imageUrl,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      episodeNumber: json['numero_episodio'],
      episodeTitle: json['titulo_episodio'],
      episodeUrl: json['url_episodio'],
      imageUrl: json['url_imagen'],
    );
  }
}

class Anime {
  final String title;
  final String url;
  final String imageUrl;

  Anime({
    required this.title,
    required this.url,
    required this.imageUrl,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      title: json['titulo'],
      url: json['url_anime'],
      imageUrl: json['url_imagen'],
    );
  }

  get type => null;

  get state => null;

  get score => null;

  get descriptionText => null;

  get sucesionNumeros => null;
}
