

import 'package:finvu_bank_pfm/core/utilities/assets.dart';
import 'package:finvu_bank_pfm/core/utilities/labels.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final bool isExpanded;
  const Footer({super.key, this.isExpanded = true});

  @override
  Widget build(BuildContext context) {
    return !isExpanded ? const Padding(
      padding: EdgeInsets.only(top: 32),
      child: FooterElement(),
    ) : const Expanded(
      child: FooterElement()
    );
  }
}

class FooterElement extends StatelessWidget {
  const FooterElement({super.key, });

  @override
  Widget build(BuildContext context) {
    return Align(
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
    );
  }
}
