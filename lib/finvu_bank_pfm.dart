library finvu_bank_pfm;

import 'package:finvu_bank_pfm/core/repository/repository_provider.dart';
import 'package:finvu_bank_pfm/presentation/pages/auth/verify_mobile_page.dart';
import 'package:finvu_bank_pfm/presentation/providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Entry point for the Finvu Bank PFM package
class FinvuBankPFM extends ConsumerWidget {
  final String mobileNo;
  const FinvuBankPFM({super.key, required this.mobileNo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(userInfoProvider.notifier).state.mobileNo = mobileNo;
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddAccount())
            );
          },
          child: const Text("Add Account"),
        ),
      ),
    );
  }
}


class AddAccount extends ConsumerWidget {
  const AddAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      error: (e,s) => const SizedBox(),
    );
  }
}


