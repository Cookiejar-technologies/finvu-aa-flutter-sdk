library finvu_bank_pfm;

import 'package:finvu_bank_pfm/core/repository/repository_provider.dart';
import 'package:finvu_bank_pfm/core/utilities/session_manager.dart';
import 'package:finvu_bank_pfm/presentation/pages/auth/verify_mobile_page.dart';
import 'package:finvu_bank_pfm/presentation/providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Entry point for the Finvu Bank PFM package
class FinvuBankPFM extends StatelessWidget {
  final String mobileNo;
  final String handleId;
  final String authToken;
  final VoidCallback? onDone;
  final VoidCallback onInteraction;
  final int interval;
  final int timeOut;
  const FinvuBankPFM({Key? key, required this.mobileNo, required this.authToken, required this.handleId, required this.onInteraction, required this.interval, required this.timeOut,this.onDone}) : super(key: key);

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
  const _FinvuBankPFM({Key? key, required this.mobileNo, required this.authToken, required this.handleId, required this.onInteraction, required this.interval, required this.timeOut, this.onDone}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.read(userInfoProvider.notifier);
    userInfo.state.mobileNo = mobileNo;
    userInfo.state.handleId = handleId;
    userInfo.state.authToken = authToken;
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
        return const SizedBox();
      },
    );
  }
}


