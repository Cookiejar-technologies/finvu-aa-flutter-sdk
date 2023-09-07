import 'package:finvu_bank_pfm/core/utilities/formats.dart';
import 'package:finvu_bank_pfm/core/utilities/labels.dart';
import 'package:finvu_bank_pfm/core/utilities/sizes.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:finvu_bank_pfm/presentation/pages/consent/providers/consent_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/widgets/app_buttons.dart';
import 'package:finvu_bank_pfm/presentation/widgets/custom_app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConsentDetailsPage extends ConsumerWidget {
  const ConsentDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(consentNotifierProvider);
    return CustomAppScaffold(
      shouldPop: true,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(Labels.consentRequestedOn,
              style: AppTypography.referenceTextMediumBlack,
            ),
            Sizes.h4,
            Text(Formats.parse2(notifier.details!.startTime),
              style: AppTypography.referenceText,
            ),
            Sizes.h24,
            const Text(Labels.detailsOfAccess,
              style: AppTypography.h3,
            ),
            Sizes.h24,
            const Text(Labels.purpose,
              style: AppTypography.referenceTextMediumBlack,
            ),
            Sizes.h4,
            Text(notifier.details!.purpose,
              style: AppTypography.referenceText,
            ),
            Sizes.h24,
            Text(notifier.details!.fetchType.toUpperCase(),
              style: AppTypography.referenceTextMediumBlack,
            ),
            Sizes.h4,
            Text(Labels.informationFetchTimes(notifier.details!.frequency.split(" ").first, notifier.details!.frequency.split(" ").last.toUpperCase()),
              style: AppTypography.referenceText,
            ),
            Sizes.h32,
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(Labels.fromDate,
                        style: AppTypography.referenceTextMediumBlack,
                      ),
                      Sizes.h4,
                      Text(Formats.parse1(notifier.details!.dateRangeFrom),
                        style: AppTypography.referenceText,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(Labels.toDate,
                        style: AppTypography.referenceTextMediumBlack,
                      ),
                      Sizes.h4,
                      Text(Formats.parse1(notifier.details!.dateRangeTo),
                        style: AppTypography.referenceText,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Sizes.h32,
            const Text(Labels.accountInformation,
              style: AppTypography.referenceTextMediumBlack,
            ),
            Sizes.h4,
            Text(notifier.details!.consentDisplay.join(", "),
              style: AppTypography.referenceText,
            ),
            Sizes.h32,
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(Labels.dataStore,
                        style: AppTypography.referenceTextMediumBlack,
                      ),
                      Sizes.h4,
                      Text(Labels.untilDate(Formats.parse1(notifier.details!.expireTime)),
                        style: AppTypography.referenceText,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(Labels.consentExpiry,
                        style: AppTypography.referenceTextMediumBlack,
                      ),
                      Sizes.h4,
                      Text(Formats.parse1(notifier.details!.expireTime),
                        style: AppTypography.referenceText,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Sizes.h48,
            Align(
              alignment: Alignment.center,
              child: AppButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                label: Labels.okay,
              ),
            )
          ]
        ),
      )
    );
  }
}