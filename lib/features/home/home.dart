import 'package:flutter/material.dart';
import 'package:news_app/features/home/categories/categories_view.dart';
import 'package:news_app/features/home/home_drawer/home_drawer.dart';
import 'package:news_app/features/home/sources/sources_view.dart';
import 'package:news_app/models/category_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Widget homeView = CategoriesView(onCategoryItemClicked: onCategoryItemClicked,);
  String title = "Home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: HomeDrawer(goToCategories: goToCategories,),
      body: homeView,
    );
  }

  void onCategoryItemClicked(CategoryModel category){
    setState(() {
      title = category.title;
      homeView = SourcesView();
    });
  }

  void goToCategories(){
      homeView = CategoriesView(onCategoryItemClicked: onCategoryItemClicked);
      Navigator.pop(context);
      setState(() {

      });
  }

}
