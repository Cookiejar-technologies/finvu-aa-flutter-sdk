import 'dart:async';
import 'package:finvu_bank_pfm/core/utilities/labels.dart';
import 'package:finvu_bank_pfm/core/utilities/sizes.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:finvu_bank_pfm/core/utilities/themes.dart';
import 'package:finvu_bank_pfm/presentation/pages/consent/consent_page.dart';
import 'package:finvu_bank_pfm/presentation/pages/verify_bank_account/providers/verify_account_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/providers/user_info_provider.dart';
import 'package:finvu_bank_pfm/presentation/widgets/app_buttons.dart';
import 'package:finvu_bank_pfm/presentation/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpWidget extends ConsumerStatefulWidget {
  const OtpWidget({super.key});

  @override
  ConsumerState<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends ConsumerState<OtpWidget> {

  Timer? timer;
  int time = 30;
  bool showResendButton = false;
  final formKey = GlobalKey<FormState>();
  
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
    final container = ProviderScope.containerOf(context);
    final notifier = ref.read(verifyAccountNotifierProvider);
    final userInfoNotifier = ref.read(userInfoProvider);
    return Theme(
      data: Themes.light, 
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(Labels.enterOtpReceived(userInfoNotifier.encodedMobileNo),
              style: AppTypography.h3,
            ),
            Sizes.h24,
            Form(
              key: formKey,
              child: TextFormField(
                onChanged: (val){
                  notifier.otp = val;
                },
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
            Sizes.h12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 48, // Fixed height to accommodate both text and button
                  child: Center(
                    child: showResendButton
                      ? AppTextButton(
                          label: Labels.resendOtp,
                          onPressed: () {
                            notifier.accLinking(
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
                Sizes.w12,
                AppButton(
                  width: 132,
                  label: Labels.confirm,
                  onPressed: (){
                    if (formKey.currentState!.validate()) {
                      notifier.verifyAccLinking(context, (){
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProviderScope(parent:container, child: const ConsentPage()))
                        );
                      });
                    }
                  }
                )
              ],
            ),
            Sizes.h36,
            const Footer()
          ]
        ),
      ),
    );
  }
}