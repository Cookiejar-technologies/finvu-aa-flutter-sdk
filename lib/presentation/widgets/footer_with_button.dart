import 'package:finvu_bank_pfm/core/utilities/assets.dart';
import 'package:finvu_bank_pfm/core/utilities/sizes.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:finvu_bank_pfm/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';

class FooterWithButton extends StatefulWidget {
  final bool showButton;
  final String buttonLabel;
  final VoidCallback? onButtonPressed;
  final bool showPadding;
  final bool isE2E;
  final List<Widget>? children;

  const FooterWithButton({super.key, required this.showButton, required this.buttonLabel, this.onButtonPressed, this.children, this.showPadding = true, this.isE2E = false});

  @override
  State<FooterWithButton> createState() => _FooterWithButtonState();
}

class _FooterWithButtonState extends State<FooterWithButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.showPadding ? const EdgeInsets.all(24) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.verified_user_outlined, size: 28,),
              Sizes.w12,
              widget.isE2E ? const Expanded(child: Text("Your data is safely end-to-end encrypted.", style: AppTypography.h3,)) :
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("100% Safe and Secure Sharing",
                      style: AppTypography.h1.copyWith(fontSize: 16),
                    ),
                    Text("by RBI regulated Account Aggregator",
                      style: AppTypography.h3.copyWith(fontSize: 12),
                    )
                  ],
                ),
              ),
              Image.asset(Assets.finvuIcon, scale: 0.75,
                package: "finvu_bank_pfm",
              )
            ],
          ),
          Sizes.h12,
          if(widget.showButton)
          widget.children != null ?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.children!,
          )
          : DarkAppButton(
            onPressed: widget.onButtonPressed,
            label: widget.buttonLabel
          ),
          Sizes.h12
        ],
      ),
    );
  }
}
