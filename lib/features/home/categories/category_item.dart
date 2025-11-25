import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/providers/home_provider.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeProvider>(context);
    return InkWell(
      onTap: (){
        homeProvider.goToSourcesView(category);
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Image.asset(category.imagePath)
      ),
    );
  }
}