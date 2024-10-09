import 'dart:async';

import 'package:finvu_bank_pfm/core/utilities/labels.dart';
import 'package:finvu_bank_pfm/core/utilities/sizes.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:finvu_bank_pfm/presentation/pages/consent/stocks_consent_page.dart';
import 'package:finvu_bank_pfm/presentation/pages/select_stocks/providers/select_stocks_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/providers/user_info_provider.dart';
import 'package:finvu_bank_pfm/presentation/widgets/app_buttons.dart';
import 'package:finvu_bank_pfm/presentation/widgets/footer_with_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/custom_app_scaffold.dart';

class VerifyMobileStocks extends ConsumerStatefulWidget {
  const VerifyMobileStocks({super.key});

  @override
  ConsumerState<VerifyMobileStocks> createState() => _VerifyMobileStocksState();
}

class _VerifyMobileStocksState extends ConsumerState<VerifyMobileStocks> {

  final TextEditingController _controller = TextEditingController();

  Timer? timer;
  int time = 30;
  bool showResendButton = false;

  startTimer() async {
    setState(() {
      time = 30;
      showResendButton = false;
    });

    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(time == 0){
        setState(() {
          timer.cancel();
          showResendButton = true;
        });
      }else{
        setState(() {
          time--;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.read(userInfoProvider);
    final notifier = ref.read(selectStocksNotifierProvider);
    return CustomAppScaffold(
      appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       padding: EdgeInsets.all(4),
              //       decoration: BoxDecoration(
              //         color: AppColors.bgGrey,
              //         borderRadius: BorderRadius.circular(6)
              //       ),
              //       child: Text("1/2"),
              //     ),
              //     Text("SKIP TO KFIN TECHNOLOGIES",
              //       style: AppTypography.h3,
              //     )
              //   ],
              // ),
              Sizes.h24,
              // Text("Link your Mutual Funds from CAMS",
              Text("Link your Stocks",
                style: AppTypography.title.copyWith(
                  color: AppColors.textDarkGrey,
                  fontSize: 20
                ),
              ),
              Sizes.h12,
              Text("Please enter the OTP sent on ${userInfo.encodedMobileNo} to securely complete the linking process",
                style: AppTypography.h3,
              ),
              Sizes.h24,
              const Text("",
                style: AppTypography.referenceTextMedium,
              ),
              Sizes.h8,
              Form(
                // key: formKey,
                child: TextFormField(
                  controller: _controller,
                  validator: (v) => v!.isEmpty ? Labels.pleaseEnterOtp : null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.tncGrey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Sizes.h8,
              SizedBox(
                height: 48, // Fixed height to accommodate both text and button
                child: Center(
                  child: showResendButton
                    ? AppTextButton(
                        label: Labels.resendOtp,
                        onPressed: () {
                          notifier.stockAccLinking(
                            context: context,
                            onOtpSent: (){},
                            ifVerified: (){}
                          );
                          startTimer();
                        },
                      )
                    : Text(
                        Labels.resendOtpIn(time),
                        style: AppTypography.h3bold.copyWith(color: AppColors.green),
                      ),
                ),
              ),
            ],
          ),
        ),
      bottomNavigationBar: FooterWithButton(
        showButton: true,
        buttonLabel: "Confirm OTP",
        onButtonPressed: (){
          final container = ProviderScope.containerOf(context);
          notifier.verifyStockAccLinking(
            context,
            _controller.text,
            () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProviderScope(
                    parent: container,
                    child: const StocksConsentPage()
                  )
                )
              );
            }
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const UnlinkStatus(
          //     status: UnlinkResStatus.SUCCESS,
          //     redirect: true,
          //   ))
          // );
        },
      )
    );
  }
}
