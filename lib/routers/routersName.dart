class RoutersName {
  static const String homeRoute = '/';
  static const String descriptionRoute = '/description';
  static const String searchRoute = '/search';
  static const String seasonRoute = '/season';
  static const String scheduleRoute = '/schedule';
}

class DescriptionArguments {
  final anime;
  final int option;
  DescriptionArguments(this.anime, this.option);
}
