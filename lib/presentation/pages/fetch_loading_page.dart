import 'package:finvu_bank_pfm/core/repository/repository_provider.dart';
import 'package:finvu_bank_pfm/core/utilities/assets.dart';
import 'package:finvu_bank_pfm/core/utilities/labels.dart';
import 'package:finvu_bank_pfm/core/utilities/sizes.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:finvu_bank_pfm/presentation/pages/auth/providers/auth_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/widgets/custom_app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FetchLoadingPage extends ConsumerStatefulWidget {
  const FetchLoadingPage({super.key});

  @override
  ConsumerState<FetchLoadingPage> createState() => _FetchLoadingPageState();
}

class _FetchLoadingPageState extends ConsumerState<FetchLoadingPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(authNotifierProvider).logout(() {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        if (ref.read(repositoryProvider).onDone != null) {
          ref.read(repositoryProvider).onDone!();
        }else{
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.loading,
              package: "finvu_bank_pfm"
            ),
            Sizes.h16,
            Text(Labels.safelyFetchingAccount,
              textAlign: TextAlign.center,
              style: AppTypography.h2.copyWith(color: AppColors.darkGrey),
            )
          ],
        ),
      )
    );
  }
}