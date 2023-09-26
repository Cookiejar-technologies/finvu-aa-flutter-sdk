import 'package:finvu_bank_pfm/core/utilities/sizes.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:finvu_bank_pfm/presentation/pages/select_institution/providers/select_institution_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/pages/verify_bank_account/providers/verify_account_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/widgets/bank_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/account_model.dart';

class BankContainer extends ConsumerWidget {
  final bool isBorder;
  final Account acc;
  const BankContainer({Key? key, required this.acc, this.isBorder = true}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectNotifier = ref.read(selectInstitutionNotifierProvider);
    final verifyNotifier = ref.read(verifyAccountNotifierProvider);
    return GestureDetector(
      onTap: (){
        if (verifyNotifier.selectedAccounts.contains(acc)) {
          verifyNotifier.removeAccount(acc);
        }else{
          verifyNotifier.addAccount(acc);
        }
        // notifier.selectedAccount = acc;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: !isBorder ? null : BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderGrey)
        ),
        child: Row(
          children: [
            BankLogo(bank: selectNotifier.selectedBank!, isExpanded: false, readOnly: true,),
            Sizes.w16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(acc.maskedAccNumber,
                    style: AppTypography.h2bold,
                  ),
                  Sizes.h4,
                  Text(acc.accType,
                    style: AppTypography.h3bold.copyWith(color: AppColors.linkBlue),
                  ),
                ],
              ),
            ),
            Consumer(
              builder: (context, ref, child){
                ref.watch(verifyAccountNotifierProvider);
                return (verifyNotifier.selectedAccounts.contains(acc)) ?
                const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.check_circle,
                    color: AppColors.green,
                  ),
                ) : const SizedBox();
              }
            )
          ],
        ),
      ),
    );
  }
}