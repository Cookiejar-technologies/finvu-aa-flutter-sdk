import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:flutter/material.dart';

class TitleSubtitleElement extends StatelessWidget {
  final String title;
  final String subtitle;
  const TitleSubtitleElement({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
          style: AppTypography.h2,
        ),
        Text(subtitle,
          style: AppTypography.h2.copyWith(
            color: AppColors.textDarkGrey,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}
