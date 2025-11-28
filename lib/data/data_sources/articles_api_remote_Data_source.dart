import 'package:dartz/dartz.dart';
import 'package:news_app/data/api/api_service.dart';
import 'package:news_app/data/api/models/articles_response/Article.dart';
import 'package:news_app/data/api/models/sources_response/Source.dart';
import 'package:news_app/data/data_sources/articles_remote_data_source.dart';

class ArticlesApiRemoteDataSource implements ArticlesRemoteDataSource{
  late ApiService apiService;
  ArticlesApiRemoteDataSource({required this.apiService});
  @override
  Future<Either<String, List<Article>>> getArticles(Source source) {
    return apiService.getArticles(source);
  }

}