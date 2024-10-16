import 'package:finvu_bank_pfm/core/utilities/constants.dart';
import 'package:finvu_bank_pfm/core/utilities/formats.dart';
import 'package:finvu_bank_pfm/core/utilities/labels.dart';
import 'package:finvu_bank_pfm/core/utilities/sizes.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:finvu_bank_pfm/presentation/pages/consent/consent_details_page.dart';
import 'package:finvu_bank_pfm/presentation/pages/consent/providers/consent_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/pages/fetch_loading_page.dart';
import 'package:finvu_bank_pfm/presentation/pages/select_institution/providers/select_institution_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/pages/verify_bank_account/providers/verify_account_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/widgets/app_buttons.dart';
import 'package:finvu_bank_pfm/presentation/widgets/bank_container.dart';
import 'package:finvu_bank_pfm/presentation/widgets/custom_app_scaffold.dart';
import 'package:finvu_bank_pfm/presentation/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConsentPage extends ConsumerWidget {
  const ConsentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final container = ProviderScope.containerOf(context);
    final notifier = ref.read(consentNotifierProvider);
    final verifyNotifier = ref.read(verifyAccountNotifierProvider);
    return CustomAppScaffold(
      shouldPop: true,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(Labels.confirmConsent,
                  style: AppTypography.h3,
                ),
                AppTextButton(
                  label: Labels.plusDetails,
                  style: AppTypography.smallReferenceTextBlack, 
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => ProviderScope(parent: container, child: const ConsentDetailsPage()))
                    );
                  }
                )
              ],
            ),
            Text(Labels.requestedOn(Formats.parse1(notifier.details!.startTime)),
              style: AppTypography.referenceText.copyWith(color: AppColors.tncGrey),
            ),
            Sizes.h12,
            const Text(Labels.bankRequiredYourConsent,
              style: AppTypography.h3,
            ),
            Sizes.h16,
            Row(
              children: [
                const Text(Labels.bullet,
                  style: AppTypography.referenceTextMedium,
                ),
                Text(Labels.fromTo(Formats.parse1(notifier.details!.dateRangeFrom), Formats.parse1(notifier.details!.dateRangeTo)),
                  style: AppTypography.referenceTextMedium,
                )
              ],
            ),
            Row(
              children: [
                const Text(Labels.bullet,
                  style: AppTypography.referenceTextMedium,
                ),
                Text(Labels.statementFreq(notifier.details!.fetchType.toUpperCase()),
                  style: AppTypography.referenceTextMedium,
                )
              ],
            ),
            Sizes.h24,
            const Divider(),
            Sizes.h8,
            const Text(Labels.selectedAccounts,
              style: AppTypography.h3,
            ),
            Sizes.h12,
            ListView(
              shrinkWrap: true,
              children: verifyNotifier.selectedAccounts.map((e) => ProviderScope(parent: container, child: BankContainer(isBorder: false, acc: e,))).toList(),
            ),
            Sizes.h8,
            const Divider(),
            AppTextButton(
              label: Labels.selectAnother,
              style: AppTypography.smallReferenceTextBlack,
              onPressed: (){
                Navigator.pop(context);
              }
            ),
            Sizes.h32,
            Align(
              alignment: Alignment.center,
              child: AppButton(
                label: Labels.approve,
                onPressed: (){
                  notifier.consentApprovalReq(Constants.accept, (){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(Labels.consentAccepted),
                      )
                    );
                  });
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => ProviderScope(parent: container, child: const FetchLoadingPage()))
                  );
                }
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: AppTextButton(
                label: Labels.deny,
                onPressed: (){
                  notifier.consentApprovalReq(Constants.deny, (){
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(Labels.consentDenied),
                      )
                    );
                  });
                }
              ),
            ),
            const Footer()
          ],
        ),
      ),
    );
  }
}