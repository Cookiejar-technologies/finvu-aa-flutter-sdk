import 'package:finvu_bank_pfm/core/utilities/sizes.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:finvu_bank_pfm/presentation/pages/select_institution/providers/select_institution_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/pages/verify_bank_account/verify_bank_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/bank_model.dart';
import 'app_network_image.dart';

class BankLogo extends ConsumerWidget {
  final Bank bank;
  final bool isExpanded;
  final bool readOnly;
  const BankLogo({super.key, required this.bank, this.isExpanded = true, this.readOnly = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(selectInstitutionNotifierProvider);
    return GestureDetector(
      onTap: readOnly ? null : (){
        notifier.selectedBank = bank;
        if (notifier.selectedBank != null) {
          notifier.getDiscoveredAccounts(context, (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VerifyBankAccount())
            );
          });
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isExpanded ?
          Expanded(
            child: AppNetworkImage(url: bank.entityLogoUri ?? "", fit: BoxFit.contain,),
          ):
          AppNetworkImage(url: bank.entityLogoUri ?? "", fit: BoxFit.contain,),
          Sizes.h8,
          Text(
            bank.fipName,
            style: AppTypography.smallText,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}