
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/resources/colors_manager.dart';
import 'package:news_app/data/api/models/articles_response/Article.dart';


class ArticleItem extends StatelessWidget {
  const ArticleItem({super.key, required this.article});
final Article article;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showArticleDetailsBottomSheet(context),
      child: Column(
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
      ),
    );
  }

  void _showArticleDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorsManager.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                      color: ColorsManager.gray,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: article.urlToImage!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                const SizedBox(height: 16),
                Text(
                  article.title ?? '',
                  style: GoogleFonts.inter(
                    color: ColorsManager.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 8),
                Text(
                  article.description ??
                      article.content ??
                      'No description available.',
                  style: GoogleFonts.inter(
                    color: ColorsManager.gray,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (article.url != null && article.url!.isNotEmpty) {
                        _openArticleUrl(context, article.url!);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No url for this article'),
                          ),
                        );
                      }
                    },
                    child: const Text('View Full Article'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  Future<void> _openArticleUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);

    final bool launched = await launchUrl(
      uri,
      mode: LaunchMode.inAppBrowserView,
    );

    if (!launched) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open article')),
      );
    }
  }

}
//
