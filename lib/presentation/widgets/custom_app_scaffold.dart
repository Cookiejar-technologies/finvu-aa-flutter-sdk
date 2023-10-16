import 'package:finvu_bank_pfm/core/repository/repository_provider.dart';
import 'package:finvu_bank_pfm/core/utilities/assets.dart';
import 'package:finvu_bank_pfm/core/utilities/session_manager.dart';
import 'package:finvu_bank_pfm/core/utilities/themes.dart';
import 'package:finvu_bank_pfm/presentation/widgets/pop_dialog.dart';
import 'package:finvu_bank_pfm/presentation/widgets/timeout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppScaffold extends ConsumerWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final bool shouldPop;
  CustomAppScaffold({super.key, required this.body, this.appBar, this.shouldPop = false});

  final PreferredSizeWidget defaultAppBar = AppBar(
    title: Image.asset(
      Assets.canaraBankIcon,
      package: "finvu_bank_pfm",
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionNotifier = ref.watch(sessionProvider);
    return Listener(
      onPointerDown: (val){
        ref.read(repositoryProvider).onInteraction!();
        sessionNotifier.reset();
      },
      child: WillPopScope(
        onWillPop: () async{
          final res = await PopWidget.show(context: context, shouldPop: shouldPop);
          if (res) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
          return res;
        },
        child: Theme(
          data: Themes.light,
          child: Scaffold(
            appBar: appBar ?? defaultAppBar,
            body: SafeArea(
              top: false,
              left: false,
              right: false,
              bottom: true,
              child: Stack(
                children: [
                  body,
                  if(!sessionNotifier.isTimerActive) const ErrorPage()
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
