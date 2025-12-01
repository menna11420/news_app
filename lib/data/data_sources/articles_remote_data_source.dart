import 'package:dartz/dartz.dart';
import 'package:news_app/data/api/models/articles_response/Article.dart';
import 'package:news_app/data/api/models/sources_response/Source.dart';

abstract class ArticlesRemoteDataSource{
  Future<Either<String,List<Article>>> getArticles(Source source, [String? searchKey]);
}