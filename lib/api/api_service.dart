import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/api/models/articles_response/Article.dart';
import 'package:news_app/api/models/articles_response/ArticlesResponse.dart';
import 'package:news_app/api/models/sources_response/Source.dart';
import 'package:news_app/api/models/sources_response/SourcesResponse.dart';
import 'package:news_app/core/resources/constant_manager.dart';
import 'package:news_app/models/category_model.dart';

class ApiService {

  static Future<Either<String, List<Source>>>getSources(CategoryModel category)async {
    var url = Uri.https(ApiConstant.baseUrl, ApiConstant.sourcesEndPoint, {
      "apiKey": ApiConstant.apiKey,
      "category": category.id,
    });
    try{
      var serverResponse = await http.get(url);
      var json = jsonDecode(serverResponse.body);
      SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);
      if (sourcesResponse.status == "error") {
        return left(sourcesResponse.message ?? '');
      } else {
        return right(sourcesResponse.sources ?? []);
      }
    }catch(exception){
      if(exception is SocketException){
        return left('No Internet connection 😑');
      }else if(exception is HttpException){
        return left("Couldn't find the post 😱");
      }else{
        return left("Bad response format 👎");
      }
    }

  }
  
  
  static Future<Either<String, List<Article>>> getArticles(Source source,[String? searchKey])async{
    Map<String,dynamic> params = {
      "apiKey":ApiConstant.apiKey,
      "sources":source.id,
    };
    if(searchKey != null){
      params["q"] = searchKey;
    }
    var url = Uri.https(ApiConstant.baseUrl, ApiConstant.articlesEndPoint,params);
    try{
      var serverResponse = await http.get(url);

      var json = jsonDecode(serverResponse.body);
      ArticlesResponse articlesResponse = ArticlesResponse.fromJson(json);
      if (articlesResponse.status == 'error') {
        return left(articlesResponse.message ?? '');
      } else {
        return right(articlesResponse.articles ?? []);
      }
    }catch(exception){
      if(exception is SocketException){
        return left('No Internet connection 😑');
      }else if(exception is HttpException){
        return left("Couldn't find the post 😱");
      }else{
        return left("Bad response format 👎");
      }
    }
  }
}
