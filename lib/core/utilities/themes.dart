import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData get light => ThemeData(
    scaffoldBackgroundColor: Colors.white,
    dividerColor: AppColors.dividerGrey,
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      backgroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(AppTypography.h3bold),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if(states.contains(MaterialState.disabled)){
            return AppColors.lightGrey;
          }
          return AppColors.buttonRed;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          )
        )
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(AppTypography.h3black),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if(states.contains(MaterialState.disabled)){
            return AppColors.lightGrey;
          }
          return AppColors.linkBlue;
        }),
      )
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.buttonRed
    ),
    fontFamily: "Raleway",
    // textTheme: ThemeData.light().textTheme.copyWith()
  );
}
