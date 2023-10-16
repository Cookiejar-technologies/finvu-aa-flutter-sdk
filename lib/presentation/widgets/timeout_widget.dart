import 'package:finvu_bank_pfm/core/utilities/labels.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:finvu_bank_pfm/core/utilities/themes.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String msg;
  const ErrorPage({super.key, this.msg = Labels.sessionTimeout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              msg,
              style: AppTypography.h3black,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16,),
            Theme(
              data: Themes.light,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text(Labels.goBack)
              ),
            )
          ],
        ),
      ),
    );
  }
}
