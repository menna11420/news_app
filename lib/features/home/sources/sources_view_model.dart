import 'package:flutter/material.dart';
import 'package:news_app/api/api_service.dart';
import 'package:news_app/api/models/sources_response/Source.dart';
import 'package:news_app/models/category_model.dart';

class SourcesViewModel extends ChangeNotifier{
  bool isLoading = false;
  String errorMessage = "";
  List<Source> sources = [];

  Future<void> loadSources(CategoryModel category)async{
    isLoading = true;
    notifyListeners();
    var result  = await ApiService.getSources(category);
    isLoading  = false;
    notifyListeners();
  result.fold((message){
    errorMessage = message;
  }, (sourcesList){
    sources = sourcesList;
  });
  notifyListeners();
  }

}