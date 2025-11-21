import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/resources/colors_manager.dart';
import 'package:news_app/models/article_model.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({super.key,required this.article});
  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.white,width: 2),
        borderRadius: BorderRadius.circular(16.r)
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
              child: Image.network(article.urlToImage)),
          SizedBox(height: 10.h,),
          Text(article.title,style: Theme.of(context).textTheme.bodyMedium,),
          SizedBox(height: 10.h,),
          Row(
            children: [
              Expanded(child: Text(article.author,style: Theme.of(context).textTheme.bodySmall,)),
              Expanded(child: Text(article.publishedAt,style: Theme.of(context).textTheme.bodySmall,)),
            ],
          ),
        ],
      ),
    );
  }
}
