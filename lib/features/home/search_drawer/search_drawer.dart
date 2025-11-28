import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/resources/colors_manager.dart';
import 'package:news_app/providers/home_provider.dart';
import 'package:provider/provider.dart';

class SearchDrawer extends StatelessWidget {
  const SearchDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeProvider>(context);
    return InkWell(
      onTap: (){
        homeProvider.goToCategoriesView();
        Navigator.pop(context);
      },
      child: Row(
        children: [
          Icon(Icons.search_rounded,color: ColorsManager.white,),
        ],
      ),
    );
  }
}
