import 'package:finvu_bank_pfm/core/utilities/constants.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:flutter/material.dart';

class DarkAppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? height;

  const DarkAppButton({super.key, required this.label, this.onPressed, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyles.darkButton,
        child: Text(label,
          style: AppTypography.h1.copyWith(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        )
      ),
    );
  }
}

class LightAppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const LightAppButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyles.lightButton,
        child: Text(label,
          style: AppTypography.h1.copyWith(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        )
      ),
    );
  }
}

class ButtonStyles{
  static ButtonStyle get lightButton => ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: const BorderSide(color: AppColors.primary)
      )
    ),
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      if(states.contains(MaterialState.disabled)){
        return AppColors.lightGrey;
      }
      return Colors.white;
    }),
  );

  static ButtonStyle get darkButton => ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: const BorderSide(color: AppColors.primary)
      )
    ),
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      if(states.contains(MaterialState.disabled)){
        return AppColors.lightGrey;
      }
      return AppColors.primary;
    }),
  );
}
