import 'package:finvu_bank_pfm/core/utilities/sizes.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:finvu_bank_pfm/presentation/pages/consent/stocks_consent_page.dart';
import 'package:finvu_bank_pfm/presentation/pages/select_stocks/providers/select_stocks_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/pages/select_stocks/verify_mobile_stocks.dart';
import 'package:finvu_bank_pfm/presentation/widgets/consent_details_button.dart';
import 'package:finvu_bank_pfm/presentation/widgets/custom_app_scaffold.dart';
import 'package:finvu_bank_pfm/presentation/widgets/footer_with_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectStocksPage extends ConsumerStatefulWidget {
  const SelectStocksPage({super.key});

  @override
  ConsumerState<SelectStocksPage> createState() => _SelectStocksPageState();
}

class _SelectStocksPageState extends ConsumerState<SelectStocksPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(selectStocksNotifierProvider).getDiscoveredStocksAccounts(context);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(selectStocksNotifierProvider);
    return CustomAppScaffold(
      appBar: AppBar(title: const Text("Stocks"),),
      bottomNavigationBar: FooterWithButton(
        buttonLabel: "Link Accounts",
        showButton: true,
        onButtonPressed: (){
          final container = ProviderScope.containerOf(context);
          notifier.stockAccLinking(
            context: context,
            onOtpSent: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProviderScope(
                    parent: container,
                    child: const VerifyMobileStocks()
                  )
                )
              );
            },
            ifVerified: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProviderScope(parent: container, child: const StocksConsentPage()))
              );
            } 
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.bgGreen,
                borderRadius: BorderRadius.circular(12)
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Colors.white,),
                  Sizes.w12,
                  Expanded(
                    child: Text("You'll receive an OTP from each of the selected RTA's.",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                  // Icon(Icons.close,
                  //   color: Colors.white,
                  // )
                ],
              ),
            ),
            Sizes.h24,
            const Text("Select RTA's and depositories to link your Mutual Funds",
              style: AppTypography.h2,
            ),
            Sizes.h16,
            ...notifier.accounts.map((e) {
              return CheckboxListTile(
                activeColor: AppColors.primary,
                title: Text(e.maskedAccNumber),
                subtitle: Text(e.accType),
                value: notifier.selectedAccounts.where((f) => f.accRefNumber == e.accRefNumber).isNotEmpty,
                onChanged: (v){
                  if(notifier.selectedAccounts.where((f) => f.accRefNumber == e.accRefNumber).isEmpty){
                    notifier.addAccount(e);
                  }else{
                    notifier.removeAccount(e);
                  }
                }
              );
              // return MfCard(
              //   acc: e,
              //   showAccCheckBox: true,
              //   isLinked: false,
              // );
            },),
            Sizes.h24,
            const ConsentDetailsButton()
          ],
        ),
      ),
    );
  }
}
