import 'package:finvu_bank_pfm/core/utilities/sizes.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:finvu_bank_pfm/presentation/models/account_model.dart';
import 'package:finvu_bank_pfm/presentation/pages/select_mutual_fund/providers/select_mutual_fund_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/widgets/border_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MfCard extends ConsumerWidget {
  final Account acc;
  final bool isLinked;
  final bool showAccCheckBox;

  const MfCard({
    super.key,
    required this.acc,
    required this.isLinked,
    this.showAccCheckBox = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(selectMfNotifierProvider);
    return BorderContainer(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.bgGrey,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: const Center(
                  child: Icon(Icons.home),
                ),
              ),
              Sizes.w16,
              Expanded(
                child: Text(acc.accRefNumber,
                  style: AppTypography.h1,
                ),
              ),
              if(isLinked && !showAccCheckBox)
                const Row(
                  children: [
                    Icon(Icons.link, color: AppColors.lightGrey,),
                    Sizes.w4,
                    Text("Linked",
                      style: AppTypography.h3,
                    )
                  ],
                ),
              if(!isLinked && !showAccCheckBox)
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Checkbox(
                    value: false,
                    onChanged: (bool? value) {},
                  ),
                )
              )
            ],
          ),
          Sizes.h24,
          // ...acc.accounts.map((e) {
          //   bool isLastIndex = acc.accounts.indexOf(e)!=acc.accounts.length-1;
          //   return Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Text("${e.linkedAccountType} - ${e.maskedAccNumber}",
          //               style: AppTypography.h3,
          //             ),
          //           ),
          //           if(showAccCheckBox)
          //           Checkbox(
          //             activeColor: AppColors.primary,
          //             visualDensity: VisualDensity.compact,
          //             value: selectedAcc.where((f) => f.fiDataId==e.fiDataId).isNotEmpty,
          //             onChanged: (v){
          //               onSelected(e);
          //             }
          //           )
          //         ],
          //       ),
          //       if(isLastIndex && !showAccCheckBox)
          //         Sizes.h12,
          //       if(isLastIndex)
          //         const Divider(color: AppColors.dividerGrey,),
          //       if(isLastIndex && !showAccCheckBox)
          //         Sizes.h12,
          //     ],
          //   );
          // }),
          if(!showAccCheckBox)
          Sizes.h8
        ],
      )
    );
  }
}
