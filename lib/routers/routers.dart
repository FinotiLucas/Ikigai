import 'package:flutter/material.dart';
import 'package:ikigai/classes/descriptionRouter.dart';
import 'package:ikigai/routers/routersName.dart';
import 'package:ikigai/screens/description/mainDescription.dart';
import 'package:ikigai/screens/mainScreen/mainScreen.dart';
import 'package:ikigai/screens/schedule/schedule.dart';
import 'package:ikigai/screens/search/Search.dart';
import 'package:ikigai/screens/season/season.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutersName.homeRoute:
      return MaterialPageRoute(builder: (_) => MainPage());

    case RoutersName.descriptionRoute:
      final DescriptionArguments arguments = settings.arguments;
      return MaterialPageRoute(
        builder: (_) => MainDescriptionPage(
          anime: arguments.anime,
          option: arguments.option,
        ),
      );

    case RoutersName.searchRoute:
      return MaterialPageRoute(builder: (_) => SearchPage());

    case RoutersName.seasonRoute:
      return MaterialPageRoute(builder: (_) => SeasonPage());

    case RoutersName.scheduleRoute:
      return MaterialPageRoute(builder: (_) => SchedulePage());

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text(
              'No route defined for ${settings.name}',
            ),
          ),
        ),
      );
  }
}
