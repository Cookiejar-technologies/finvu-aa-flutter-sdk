library finvu_bank_pfm;

import 'dart:developer';

import 'package:finvu_bank_pfm/core/repository/repository_provider.dart';
import 'package:finvu_bank_pfm/core/utilities/labels.dart';
import 'package:finvu_bank_pfm/core/utilities/session_manager.dart';
import 'package:finvu_bank_pfm/presentation/pages/auth/providers/auth_notifier_provider.dart';
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
class FinvuBankPFM extends ConsumerStatefulWidget {
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
  ConsumerState<FinvuBankPFM> createState() => _FinvuBankPFM();
}


class _FinvuBankPFM extends ConsumerState<FinvuBankPFM> {

  @override
  void initState() {
    super.initState();

     final userInfo = ref.read(userInfoProvider.notifier);
    userInfo.state.mobileNo = widget.mobileNo;
    userInfo.state.handleId = widget.handleId;
    userInfo.state.authToken = widget.authToken;
    userInfo.state.devMode = widget.devMode;
    userInfo.state.aaType = widget.aaType;
    userInfo.state.pan = widget.pan;
    ref.read(repositoryProvider).onInteraction = widget.onInteraction;
    ref.read(sessionProvider).init(widget.interval, widget.timeOut);
    if(widget.onDone != null){
      ref.read(repositoryProvider).onDone = widget.onDone;
    }

    Future.microtask(() {
      ref.read(authNotifierProvider).sendOtp();
    });
  }
  
  @override
  Widget build(BuildContext context) {
   
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


