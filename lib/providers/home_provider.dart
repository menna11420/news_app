import 'package:flutter/material.dart';
import 'package:news_app/features/home/categories/categories_view.dart';
import 'package:news_app/features/home/sources/sources_view.dart';
import 'package:news_app/features/home/search/search_view.dart';
import 'package:news_app/models/category_model.dart';

class HomeProvider extends ChangeNotifier{
  Widget homeView = CategoriesView();
  String title = "Home";

  void goToSourcesView(CategoryModel category){
    homeView = SourcesView(category: category,);
    title = category.title;
    notifyListeners();
  }

  void goToCategoriesView(){
    homeView = CategoriesView();
    notifyListeners();
  }

  void goToSearchView() {
    homeView = const SearchView();
    title = "Search";
    notifyListeners();
  }
}