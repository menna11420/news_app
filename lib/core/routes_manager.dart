import 'package:flutter/widgets.dart';

import '../features/home/home.dart';
import '../features/splash/splash.dart';

abstract class RoutesManager{
  static const String splash = "/splash";
  static const String home = "/home";
  static const String newsDetails = "/newsDetails";

  static Map<String,WidgetBuilder> router = {
    splash : (context) => Splash(),
    home : (context) => Home(),

  };
}