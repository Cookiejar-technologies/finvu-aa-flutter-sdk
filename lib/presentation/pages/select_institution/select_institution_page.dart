import 'package:finvu_bank_pfm/core/utilities/sizes.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:finvu_bank_pfm/presentation/pages/select_institution/providers/select_institution_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/pages/select_institution/search_bank_page.dart';
import 'package:finvu_bank_pfm/presentation/pages/verify_bank_account/verify_bank_account.dart';
import 'package:finvu_bank_pfm/presentation/widgets/bank_logo.dart';
import 'package:finvu_bank_pfm/presentation/widgets/custom_app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utilities/labels.dart';

class SelectInstitutionPage extends ConsumerWidget {
  const SelectInstitutionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainContainer = ProviderScope.containerOf(context);
    final notifier = ref.watch(selectInstitutionNotifierProvider);
    return CustomAppScaffold(
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 24),
              child: Text(
                Labels.selectInstitution,
                style: AppTypography.h1,
              ),
            ),
            Sizes.h16,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                Labels.trackActivity,
                style: AppTypography.referenceText,
              ),
            ),
            Sizes.h16,
            const Divider(),
            Sizes.h16,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                Labels.selectBank,
                style: AppTypography.referenceTextMedium,
              ),
            ),
            Sizes.h16,
            GridView.builder(
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, 
                childAspectRatio: 1.5
              ),
              itemBuilder: (context, index) {
                return ProviderScope(parent: mainContainer, child: BankLogo(bank: notifier.banks[index],));
              },
            ),
            Sizes.h24,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                onTap: ()async{
                  final selBank = await showSearch(context: context, delegate: SearchBank(banks: notifier.banks, ref: ref));
                  if(selBank != null){
                    notifier.selectedBank = selBank;
                    notifier.getDiscoveredAccounts(context, (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProviderScope(parent: mainContainer, child: const VerifyBankAccount()))
                      );
                    });
                  }
                },
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.tncGrey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.tncGrey,
                  ),
                  hintText: Labels.searchInstitution,
                  hintStyle: AppTypography.h2
                ),
              ),
            ),
            Sizes.h8,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                Labels.finvuAccountAggregator,
                style: AppTypography.smallReferenceText,
              ),
            ),
            Expanded(
              child: Align(
              alignment: Alignment.bottomCenter,
                child: RichText(
                text: TextSpan(
                  text: Labels.byContinuing,
                  style: AppTypography.smallReferenceTextBold,
                  children: [
                    TextSpan(
                      text: Labels.tNc,
                        style: AppTypography.smallReferenceTextBold.copyWith(color: AppColors.linkBlue)
                      )
                    ]
                  )
                ),
              )
            )
          ],
        ),
      )
    );
  }
}
