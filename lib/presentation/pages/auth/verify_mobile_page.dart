import 'dart:async';
import 'package:finvu_bank_pfm/core/utilities/labels.dart';
import 'package:finvu_bank_pfm/core/utilities/sizes.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:finvu_bank_pfm/presentation/pages/auth/providers/auth_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/pages/select_institution/select_institution_page.dart';
import 'package:finvu_bank_pfm/presentation/providers/user_info_provider.dart';
import 'package:finvu_bank_pfm/presentation/widgets/app_buttons.dart';
import 'package:finvu_bank_pfm/presentation/widgets/custom_app_scaffold.dart';
import 'package:finvu_bank_pfm/presentation/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class VerifyMobilePage extends ConsumerStatefulWidget {
  const VerifyMobilePage({super.key});

  @override
  ConsumerState<VerifyMobilePage> createState() => _VerifyMobilePageState();
}

class _VerifyMobilePageState extends ConsumerState<VerifyMobilePage> {

  late Timer timer;
  int time = 30;
  final formKey = GlobalKey<FormState>();
  
  startTimer()async{
    timer = Timer.periodic(const Duration(seconds: 1), (timer) { 
      if(time == 0){
        setState(() {
          timer.cancel();
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
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final container = ProviderScope.containerOf(context);
    final notifier = ref.watch(authNotifierProvider);
    final userInfoNotifier = ref.read(userInfoProvider);
    return CustomAppScaffold(
      isFirst: true,
      shouldPop: true,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(Labels.verifyMobileNo,
              style: AppTypography.h1,
            ),
            Sizes.h12,
            Text(Labels.enterOtpSent(userInfoNotifier.encodedMobileNo),
              style: AppTypography.referenceText,
            ),
            Sizes.h24,
            const Text(Labels.enterOtp,
              style: AppTypography.referenceTextMedium,
            ),
            Sizes.h8,
            Form(
              key: formKey,
              child: TextFormField(
                initialValue: notifier.otp,
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
            Sizes.h8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextButton(
                  label: Labels.resendOtp,
                  onPressed: timer.isActive ? null : (){
                    notifier.sendOtp();
                  },
                ),
                Text(Labels.inTimeSecs(time),
                  style: AppTypography.h3bold.copyWith(color: AppColors.green),
                )
              ],
            ),
            Sizes.h32,
            notifier.loading ? const Center(child: CircularProgressIndicator()) :
            Align(
              alignment: Alignment.center,
              child: AppButton(
                onPressed: (){
                  if (formKey.currentState!.validate()) {
                    notifier.verifyOtp(context, (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProviderScope(parent: container, child: const SelectInstitutionPage()))
                      );
                    });
                  }
                },
                label: Labels.verify,
              ),
            ),
            const Footer(showTnC: true,)
          ],
        ),
      )
    );
  }
}
