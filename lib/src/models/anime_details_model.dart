class Anime {
  final String backgroundImage;
  final List<String> descriptionText;
  final String imageSrc;
  final double score;
  final String state;
  final List<int> sucesionNumeros;
  final String title;
  final String type;
  final String url;

  Anime({
    required this.backgroundImage,
    required this.descriptionText,
    required this.imageSrc,
    required this.score,
    required this.state,
    required this.sucesionNumeros,
    required this.title,
    required this.type,
    required this.url,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      backgroundImage: json['background_image'],
      descriptionText: List<String>.from(json['description_text']),
      imageSrc: json['image_src'],
      score: double.parse(json['score']),
      state: json['state'],
      sucesionNumeros: List<int>.from(json['sucesion_numeros']),
      title: json['title'],
      type: json['type'],
      url: json['url'],
    );
  }
}
