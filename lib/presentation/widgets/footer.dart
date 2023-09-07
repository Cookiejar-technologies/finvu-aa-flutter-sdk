

import 'package:finvu_bank_pfm/core/utilities/assets.dart';
import 'package:finvu_bank_pfm/core/utilities/labels.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(Labels.poweredBy,
              style: AppTypography.footerText,
            ),
            Image.asset(Assets.finvuIcon,
              package: "finvu_bank_pfm",
            )
          ]
        ),
      )
    );
  }
}