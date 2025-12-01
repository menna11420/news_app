import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/resources/colors_manager.dart';
import 'package:news_app/data/api/models/articles_response/Article.dart';
import 'package:url_launcher/url_launcher.dart';

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
          // \u0635\u0648\u0631\u0629 \u0627\u0644\u062e\u0628\u0631
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: CachedNetworkImage(
              imageUrl: article.urlToImage ?? '',
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                height: 200.h,
                color: ColorsManager.gray.withOpacity(0.3),
                alignment: Alignment.center,
                child: Icon(
                  Icons.broken_image_outlined,
                  color: ColorsManager.white.withOpacity(0.7),
                  size: 32.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),

          // \u0639\u0646\u0648\u0627\u0646 \u0627\u0644\u062e\u0628\u0631
          Text(
            article.title ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: ColorsManager.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),

          // \u0627\u0644\u0643\u0627\u062a\u0628 \u0648 \u0627\u0644\u062a\u0627\u0631\u064a\u062e
          Row(
            children: [
              Expanded(
                child: Text(
                  article.author ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: ColorsManager.gray,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  article.publishedAt ?? '',
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: ColorsManager.gray,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // *************** Bottom Sheet ***************

  void _showArticleDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 12.w,
            right: 12.w,
            top: 12.h,
            bottom: 12.h + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // \u0635\u0648\u0631\u0629 \u062c\u0648\u0647 \u0627\u0644\u0640 bottom sheet
                    if (article.urlToImage != null &&
                        article.urlToImage!.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: CachedNetworkImage(
                          imageUrl: article.urlToImage!,
                          height: 200.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                    SizedBox(height: 12.h),

                    // \u0627\u0644\u0639\u0646\u0648\u0627\u0646
                    Text(
                      article.title ?? '',
                      style: GoogleFonts.inter(
                        color: ColorsManager.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // \u0627\u0644\u0648\u0635\u0641 / \u0627\u0644\u0645\u062d\u062a\u0648\u0649
                    Text(
                      article.description ??
                          article.content ??
                          'No description available.',
                      style: GoogleFonts.inter(
                        color: ColorsManager.black.withOpacity(0.8),
                        fontSize: 13.sp,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // \u0632\u0631 View Full Article
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 14.h,
                          ),
                        ),
                        onPressed: () {
                          if (article.url != null &&
                              article.url!.isNotEmpty) {
                            _openArticleUrl(context, article.url!);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('No URL for this article'),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'View Full Article',
                          style: GoogleFonts.inter(
                            color: ColorsManager.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // *************** Open in in-app browser ***************

  Future<void> _openArticleUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);

    final bool launched = await launchUrl(
      uri,
      mode: LaunchMode.inAppBrowserView, // \u064a\u0641\u062a\u062d \u0632\u064a \u0627\u0644\u0644\u064a \u0641\u064a \u0627\u0644\u0635\u0648\u0631\u0629
    );

    if (!launched) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open article'),
        ),
      );
    }
  }
}
