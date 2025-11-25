import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/api/api_service.dart';
import 'package:news_app/core/resources/colors_manager.dart';
import 'package:news_app/features/home/sources/article_item.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';

import '../../../api/models/sources_response/Source.dart';

class SourcesView extends StatelessWidget {
  SourcesView({super.key,required this.category});
  final CategoryModel category ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(future: ApiService.getSources(category), builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          }
          List<Source> sources = snapshot.data?.sources ?? [];
          return DefaultTabController(
              length: sources.length,
              child: TabBar(
                  tabAlignment: TabAlignment.start,
                  dividerColor: Colors.transparent,
                  indicatorColor: ColorsManager.white,
                  labelStyle: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.bold,color: ColorsManager.white),
                  unselectedLabelStyle: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w500,color: ColorsManager.white),
                  isScrollable: true,
                  tabs: sources.map((source) => Tab(text: source.name,)).toList()));
        }),
      ],
    );
  }
}
