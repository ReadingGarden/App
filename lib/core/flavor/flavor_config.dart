enum Flavor { dev, prod }

class FlavorConfig {
  static Flavor _flavor = Flavor.prod;

  static Flavor get flavor => _flavor;

  static bool get isDev => _flavor == Flavor.dev;
  static bool get isProd => _flavor == Flavor.prod;

  static void setFlavor(Flavor flavor) {
    _flavor = flavor;
  }

  static String get baseUrl {
    switch (_flavor) {
      case Flavor.dev:
        // TODO: 실제 dev 서버 URL로 교체
        return 'https://readinggarden-dev.duckdns.org';
      case Flavor.prod:
        return 'https://readinggarden.duckdns.org';
    }
  }

  static String get appName {
    switch (_flavor) {
      case Flavor.dev:
        return '독서가든 Dev';
      case Flavor.prod:
        return '독서가든';
    }
  }
}
