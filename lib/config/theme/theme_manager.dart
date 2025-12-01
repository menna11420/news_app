import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/resources/colors_manager.dart';

class ThemeManager{
  static final ThemeData light = ThemeData();
  static final ThemeData dark = ThemeData(
    appBarTheme: AppBarThemeData(
      backgroundColor: ColorsManager.black,
      foregroundColor: ColorsManager.white,
      titleTextStyle: GoogleFonts.inter(fontSize: 20.sp,fontWeight: FontWeight.w500,color: ColorsManager.white),
      centerTitle: true,
    ),
    scaffoldBackgroundColor: ColorsManager.black,
    textTheme: TextTheme(
      titleMedium: GoogleFonts.inter(fontWeight: FontWeight.w500,fontSize: 24.sp,color: ColorsManager.white),
      bodyMedium: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 16.sp,color: ColorsManager.white),
      bodySmall: GoogleFonts.inter(fontWeight: FontWeight.w500,fontSize: 12.sp,color: ColorsManager.gray),
    )
  );
}