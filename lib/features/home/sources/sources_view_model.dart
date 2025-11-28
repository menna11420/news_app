import 'package:flutter/material.dart';
import 'package:news_app/data/api/api_service.dart';
import 'package:news_app/data/api/models/sources_response/Source.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/repositories/sources_repository.dart';

class SourcesViewModel extends ChangeNotifier{
  SourcesRepository sourcesRepository;
  SourcesViewModel({required this.sourcesRepository});
  bool isLoading = false;
  String errorMessage = "";
  List<Source> sources = [];

  Future<void> loadSources(CategoryModel category)async{
    isLoading = true;
    notifyListeners();
    var result  = await sourcesRepository.getSources(category);
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