import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/resources/colors_manager.dart';
import 'package:news_app/providers/home_provider.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeProvider>(context);
    return Drawer(
      backgroundColor: ColorsManager.black,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 166.h,
            color: ColorsManager.white,
            child:
            Text("News App",
              style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.black),),
          ),
          SizedBox(height: 16.h,),
          InkWell(
            onTap: (){
              homeProvider.goToCategoriesView();
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Icon(Icons.home_outlined,color: ColorsManager.white,),
                SizedBox(width: 8.w,),
                Text("Go To Categories",
                  style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.white),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
