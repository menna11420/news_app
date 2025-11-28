import 'package:dartz/dartz.dart';
import 'package:news_app/data/api/models/sources_response/Source.dart';
import 'package:news_app/models/category_model.dart';

abstract class SourcesRemoteDataSource{
  Future<Either<String,List<Source>>> getSources(CategoryModel category);
}