import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:flutter/material.dart';

class BankPill extends StatelessWidget {
  final bool isSelected;
  final String title;
  final bool isFirst;
  const BankPill({super.key, required this.title, required this.isSelected, required this.isFirst});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isFirst ? null : const EdgeInsets.only(left: 12),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.primary)
      ),
      child: Text(title,
        style: AppTypography.h2.copyWith(color: !isSelected ? AppColors.primary : Colors.white),
      ),
    );
  }
}