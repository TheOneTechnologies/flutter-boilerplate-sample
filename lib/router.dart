import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naming_convention/ui/album/albums_list.dart';

import 'ui/home/dashboard.dart';
import 'ui/login/login_screen.dart';
import 'ui/news/news_screen.dart';
import 'ui/splash/splash.dart';

class Router {
  //static variables
  static const homeRoute = '/';
  static const dashboardRoute = '/dashboard';
  static const loginRoute = '/login';
  static const albumRoute = '/album';
  static const newsRoute = '/news';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Splash());
      case dashboardRoute:
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => Login());
      case albumRoute:
        return MaterialPageRoute(builder: (_) => AlbumsList());
      case newsRoute:
        return MaterialPageRoute(builder: (_) => NewsList());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
