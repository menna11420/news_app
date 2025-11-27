import 'package:flutter/material.dart';
import 'package:news_app/api/api_service.dart';
import 'package:news_app/api/models/articles_response/Article.dart';
import 'package:news_app/api/models/sources_response/Source.dart';


class ArticlesViewModel extends ChangeNotifier{
  bool isLoading = false;
  String errorMessage = "";
  List<Article> articles = [];

  void loadArticles(Source source,[String? searchKey])async{
    isLoading = true;
    notifyListeners();
    var result = await ApiService.getArticles(source,searchKey);
    isLoading = false ;
    notifyListeners();
    result.fold((message){
      errorMessage = message;
    }, (articlesList){
      articles = articlesList;
    });
    notifyListeners();
  }
}