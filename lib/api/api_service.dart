import 'dart:convert';

import 'package:news_app/api/models/sources_response/SourcesResponse.dart';
import 'package:news_app/core/resources/constant_manager.dart';
import 'package:news_app/models/category_model.dart';
import 'package:http/http.dart' as http;


class ApiService{
  static Future<SourcesResponse>getSources(CategoryModel category)async{
    Uri url = Uri.https(ApiConstant.baseUrl,ApiConstant.sourcesEndPoint,{
      "apiKey": ApiConstant.apiKey,
      "category": category.id,
    });
    var serverResponse = await http.get(url);
    var json = jsonDecode(serverResponse.body);
    return SourcesResponse.fromJson(json);
  }
}