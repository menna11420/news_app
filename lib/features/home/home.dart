import 'package:flutter/material.dart';
import 'package:news_app/features/home/categories/categories_view.dart';
import 'package:news_app/features/home/home_drawer/home_drawer.dart';
import 'package:news_app/features/home/sources/sources_view.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/providers/home_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});


  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(homeProvider.title),
      ),
      drawer: HomeDrawer(),
      body: homeProvider.homeView,
    );
  }
}
