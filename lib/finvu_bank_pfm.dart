library finvu_bank_pfm;

import 'dart:developer';

import 'package:finvu_bank_pfm/core/repository/repository_provider.dart';
import 'package:finvu_bank_pfm/core/utilities/labels.dart';
import 'package:finvu_bank_pfm/core/utilities/session_manager.dart';
import 'package:finvu_bank_pfm/presentation/pages/auth/verify_mobile_page.dart';
import 'package:finvu_bank_pfm/presentation/providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AAType{
  deposit,
  mutualFund,
  equity
}

///Entry point for the Finvu Bank PFM package
class FinvuBankPFM extends StatelessWidget {
  final String mobileNo;
  final String handleId;
  final String authToken;
  final VoidCallback? onDone;
  final VoidCallback onInteraction;
  final int interval;
  final int timeOut;
  final bool devMode;
  final AAType aaType;
  final String? pan;
  const FinvuBankPFM({super.key, required this.mobileNo, required this.authToken, required this.handleId, required this.onInteraction, required this.interval, required this.timeOut, required this.devMode, required this.aaType, required this.pan, this.onDone});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: _FinvuBankPFM(
        mobileNo: mobileNo,
        handleId: handleId,
        authToken: authToken,
        onDone: onDone,
        onInteraction: onInteraction,
        interval: interval,
        timeOut: timeOut,
        devMode: devMode,
        aaType: aaType,
        pan: pan
      )
    );
  }
}


class _FinvuBankPFM extends ConsumerWidget {
  final String mobileNo;
  final String handleId;
  final String authToken;
  final VoidCallback? onDone;
  final VoidCallback onInteraction;
  final int interval;
  final int timeOut;
  final bool devMode;
  final AAType aaType;
  final String? pan;
  const _FinvuBankPFM({super.key, required this.mobileNo, required this.authToken, required this.handleId, required this.onInteraction, required this.interval, required this.timeOut, required this.devMode, required this.aaType, required this.pan, this.onDone});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.read(userInfoProvider.notifier);
    userInfo.state.mobileNo = mobileNo;
    userInfo.state.handleId = handleId;
    userInfo.state.authToken = authToken;
    userInfo.state.devMode = devMode;
    userInfo.state.aaType = aaType;
    userInfo.state.pan = pan;
    ref.read(repositoryProvider).onInteraction = onInteraction;
    ref.read(sessionProvider).init(interval, timeOut);
    if(onDone != null){
      ref.read(repositoryProvider).onDone = onDone;
    }
    final consentAsync = ref.watch(consentProvider);
    return consentAsync.when(
      data: (data){
        return const VerifyMobilePage();
      },
      loading: () => const Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (e,s) {
        print(e);
        print(s);
        log("Something went wrong : AA Home",stackTrace: s);
        return const SizedBox(
          child: Center(child: Text("Something went wrong : AA Home")),
        );
      },
    );
  }
}


