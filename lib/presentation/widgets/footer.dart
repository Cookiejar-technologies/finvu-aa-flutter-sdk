

import 'package:finvu_bank_pfm/core/utilities/assets.dart';
import 'package:finvu_bank_pfm/core/utilities/labels.dart';
import 'package:finvu_bank_pfm/core/utilities/sizes.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  final bool isExpanded;
  final bool showTnC;
  const Footer({super.key, this.isExpanded = true, this.showTnC = false});

  @override
  Widget build(BuildContext context) {
    return !isExpanded ? Padding(
      padding: const EdgeInsets.only(top: 32),
      child: FooterElement(showTnc: showTnC,),
    ) : Expanded(
      child: FooterElement(showTnc: showTnC,)
    );
  }
}

class FooterElement extends StatelessWidget {
  final bool showTnc;
  const FooterElement({super.key, this.showTnc = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if(showTnc)
          GestureDetector(
            onTap: (){
              launchUrl(Uri.parse("https://finvu.in/terms"));
            },
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: "By continuing you agree to ",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54
                ),
                children: [
                  TextSpan(
                    text: "Finvu Terms & Conditions",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      decoration: TextDecoration.underline
                    )
                  )
                ]
              )
            ),
          ),
          if(showTnc)
          Sizes.h8,
          if(showTnc)
          const Text("Finvu is the brand name of Cookiejar Technologies Private Ltd which is a RBI licensed and regulated NBFC AA",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54
            ),
          ),
          if(showTnc)
          Sizes.h8,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(Labels.poweredBy,
                style: AppTypography.footerText,
              ),
              Image.asset(Assets.finvuIcon,
                package: "finvu_bank_pfm",
              ),
            ]
          ),
        ],
      ),
    );
  }
}
