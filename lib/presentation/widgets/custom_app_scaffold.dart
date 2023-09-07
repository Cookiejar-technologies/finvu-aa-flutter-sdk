import 'package:finvu_bank_pfm/core/utilities/assets.dart';
import 'package:finvu_bank_pfm/core/utilities/themes.dart';
import 'package:finvu_bank_pfm/presentation/widgets/pop_dialog.dart';
import 'package:flutter/material.dart';

class CustomAppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final bool shouldPop;
  CustomAppScaffold({super.key, required this.body, this.appBar, this.shouldPop = false});

  final PreferredSizeWidget defaultAppBar = AppBar(
    title: Image.asset(
      Assets.unionBankIcon,
      package: "finvu_bank_pfm",
    ),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => PopWidget.show(context: context, shouldPop: shouldPop),
      child: Theme(
        data: Themes.light,
        child: Scaffold(
          appBar: appBar ?? defaultAppBar,
          body: SafeArea(
            top: false,
            left: false,
            right: false,
            bottom: true,
            child: body
          ),
        ),
      ),
    );
  }
}
