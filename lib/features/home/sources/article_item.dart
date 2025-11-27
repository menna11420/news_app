
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/api/models/articles_response/Article.dart';
import 'package:news_app/core/resources/colors_manager.dart';


class ArticleItem extends StatelessWidget {
  const ArticleItem({super.key, required this.article});
final Article article;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: CachedNetworkImage(
              imageUrl: article.urlToImage ?? '',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),),
        Text(article.title ?? '', style: GoogleFonts.inter(color: ColorsManager.white,fontWeight: FontWeight.bold, fontSize: 16.sp),)
    ,SizedBox(height: 10.h,)
      ,Row(
        children: [
          Expanded(child: Text(article.author ?? '', style: GoogleFonts.inter(color: ColorsManager.gray,fontWeight: FontWeight.w500, fontSize: 12.sp),)),
          Expanded(child: Text(article.publishedAt ?? '', style: GoogleFonts.inter(color: ColorsManager.gray,fontWeight: FontWeight.w500, fontSize: 12.sp),)),

        ],
      )
      ],
    );
  }
}
//
