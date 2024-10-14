import 'package:finvu_bank_pfm/core/utilities/labels.dart';
import 'package:finvu_bank_pfm/core/utilities/sizes.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:finvu_bank_pfm/presentation/pages/select_institution/providers/select_institution_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/pages/verify_bank_account/providers/verify_account_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/providers/user_info_provider.dart';
import 'package:finvu_bank_pfm/presentation/widgets/app_buttons.dart';
import 'package:finvu_bank_pfm/presentation/widgets/bank_container.dart';
import 'package:finvu_bank_pfm/presentation/widgets/bottom_sheet_otp.dart';
import 'package:finvu_bank_pfm/presentation/widgets/custom_app_scaffold.dart';
import 'package:finvu_bank_pfm/presentation/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../consent/consent_page.dart';

class VerifyBankAccount extends ConsumerWidget {
  const VerifyBankAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final container = ProviderScope.containerOf(context);
    final mainContainer = ProviderScope.containerOf(context);
    final notifier = ref.watch(verifyAccountNotifierProvider);
    final bankNotifier = ref.watch(selectInstitutionNotifierProvider);
    final userInfoNotifier = ref.read(userInfoProvider);
    return CustomAppScaffold(
      shouldPop: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(Labels.verifyBankAccount,
                style: AppTypography.h1,
              ),
              Sizes.h12,
              Text(Labels.weFoundTheBelowAccounts(userInfoNotifier.encodedMobileNo),
                style: AppTypography.referenceText,
              ),
              Sizes.h16,
              ...bankNotifier.accounts.map((e) {
                return ProviderScope(parent: mainContainer, child: BankContainer(acc: e));
              },),
              Sizes.h24,
              Text(Labels.willSendOtp(bankNotifier.selectedBank!.fipName),
                style: AppTypography.h3,
              ),
              Sizes.h12,
              Consumer(
                builder: (context, ref, child){
                  return Align(
                    alignment: Alignment.centerRight,
                    child: AppButton(
                      width: 132,
                      label: Labels.next,
                      onPressed: notifier.selectedAccounts.isEmpty ? null : (){
                        notifier.accLinking(
                          context: context,
                          onOtpSent: (){
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                                ),
                                context: context,
                                builder: (context){
                                  return ProviderScope(parent: container, child: const OtpWidget());
                                }
                            );
                          },
                          ifVerified: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProviderScope(parent: container, child: const ConsentPage()))
                            );
                          }
                        );
                      }
                    ),
                  );
                }
              ),
              const Footer(isExpanded: false,)
            ],
          ),
        ),
      ),
    );
  }
}