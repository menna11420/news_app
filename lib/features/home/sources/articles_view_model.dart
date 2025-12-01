import 'package:flutter/material.dart';
import 'package:news_app/data/api/api_service.dart';
import 'package:news_app/data/api/models/articles_response/Article.dart';
import 'package:news_app/data/api/models/sources_response/Source.dart';
import 'package:news_app/repositories/articles_repository.dart';

class ArticlesViewModel extends ChangeNotifier{
  ArticlesRepository articlesRepository;
  ArticlesViewModel({required this.articlesRepository});
  bool isLoading = false;
  String errorMessage = "";
  List<Article> articles = [];

  void loadArticles(Source source,[String? searchKey])async{
    isLoading = true;
    notifyListeners();
    var result = await articlesRepository.getArticles(source,searchKey);
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