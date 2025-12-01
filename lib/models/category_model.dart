import 'package:news_app/core/resources/assets_manager.dart';

class CategoryModel{
  String id;
  String title;
  String imagePath;

  CategoryModel({
    required this.id,
    required this.title,
    required this.imagePath
  });

  static List<CategoryModel> categories = [
    CategoryModel(id: "business", title: "Business", imagePath: ImageAssets.business),
    CategoryModel(id: "sports", title: "Sports", imagePath: ImageAssets.sports),
    CategoryModel(id: "entertainment", title: "Entertainment", imagePath: ImageAssets.entertainment),
    CategoryModel(id: "general", title: "General", imagePath: ImageAssets.general),
    CategoryModel(id: "technology", title: "Technology", imagePath: ImageAssets.technology),
    CategoryModel(id: "science", title: "Science", imagePath: ImageAssets.science),
    CategoryModel(id: "health", title: "Health", imagePath: ImageAssets.health),
  ];
}