import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/config/theme/theme_manager.dart';
import 'package:news_app/core/routes_manager.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,chile) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesManager.splash,
        routes: RoutesManager.router,
        theme: ThemeManager.light,
        darkTheme: ThemeManager.dark,
        themeMode: ThemeMode.dark,
        locale: Locale("en"),
        supportedLocales: [Locale("en"),Locale("ar")],
      ),
    );
  }
}
