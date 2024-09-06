import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:flutter/material.dart';

class BorderContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? borderColor;
  const BorderContainer({super.key, required this.child , this.padding, this.margin, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? AppColors.dividerGrey),
        borderRadius: BorderRadius.circular(8)
      ),
      child: child,
    );
  }
}

class HeaderContainer extends StatelessWidget {
  final Widget child;
  const HeaderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: AppColors.bgGrey,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
        ),
        child: child,
      ),
    );
  }
}

