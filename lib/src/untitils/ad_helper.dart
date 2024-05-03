class AdHelper {
  AdHelper._();

  static AdHelper? _instance;

  static AdHelper get instance {
    return _instance ??= AdHelper._();
  }

  bool _test = true;

  void configure({final bool? test}) {
    if (test == null) return;
    _test = test;
  }

  String get bannerAdId {
    if (_test) {
      return 'ca-app-pub-5756543591860739/2067031536';
    }
    return 'ca-app-pub-5756543591860739/2067031536';
  }
}
