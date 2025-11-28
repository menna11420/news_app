import 'package:dartz/dartz.dart';
import 'package:news_app/data/api/models/sources_response/Source.dart';
import 'package:news_app/data/data_sources/sources_remote_data_source.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/repositories/sources_repository.dart';

class SourcesRepositoryImpl implements SourcesRepository{
  late SourcesRemoteDataSource dataSource;
  SourcesRepositoryImpl({required this.dataSource});
  @override
  Future<Either<String, List<Source>>> getSources(CategoryModel category) {
  return dataSource.getSources(category);
  }

}