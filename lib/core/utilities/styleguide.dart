import 'package:flutter/material.dart';

class AppColors {
  static const Color linkBlue = Color.fromRGBO(45, 156, 219, 1);
  static const Color green = Color.fromRGBO(39, 174, 96, 1);
  static const Color buttonRed = Color.fromRGBO(235, 87, 87, 1);
  static const Color black = Color.fromRGBO(0, 0, 0, 1);

  ///greys
  static const Color darkGrey = Color.fromRGBO(79, 79, 79, 1);
  static const Color lightGrey = Color.fromRGBO(130, 130, 130, 1);
  static const Color tncGrey = Color.fromRGBO(189, 189, 189, 1);
  static const Color borderGrey = Color.fromRGBO(224, 224, 224, 1);
  static const Color textDarkGrey = Color.fromRGBO(51, 51, 51, 1);
  static const Color dividerGrey = Color.fromRGBO(224, 224, 224, 1);
}

class AppTypography {
  static const h1 = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.05,
      color: AppColors.darkGrey);

  static const h2 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.05,
      color: AppColors.tncGrey);

  static const h2bold = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.05,
      color: AppColors.textDarkGrey);

  static const h3 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.05,
      color: AppColors.lightGrey);

  static const h3black = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.05,);

  static const h3bold = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.05,
      color: AppColors.lightGrey);

  static const referenceTextMedium = TextStyle(
      color: AppColors.darkGrey,
      fontSize: 13,
      letterSpacing: 0.05,
      fontWeight: FontWeight.w600);

  static const referenceTextMediumBlack = TextStyle(
      color: AppColors.black,
      fontSize: 13,
      letterSpacing: 0.05,
      fontWeight: FontWeight.w600);

  static const referenceText = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.05,
      color: AppColors.lightGrey);

  static const smallReferenceTextBlack = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.05,);

  static const smallReferenceText = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.05,
      color: AppColors.lightGrey);

  static const smallReferenceTextBold = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.05,
      color: AppColors.lightGrey);

  static const smallText = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.05,
      color: AppColors.darkGrey);

  static const footerText = TextStyle(
      fontSize: 9,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.05,
      color: AppColors.tncGrey);
}
