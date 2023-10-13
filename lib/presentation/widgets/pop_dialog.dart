import 'package:finvu_bank_pfm/core/utilities/labels.dart';
import 'package:finvu_bank_pfm/presentation/widgets/app_buttons.dart';
import 'package:flutter/material.dart';

class PopWidget{
  static Future<bool> show({required BuildContext context, bool shouldPop = false})async{
    if(shouldPop) return true;
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text(Labels.alert),
          content: const Text(Labels.pressingBack),
          actionsOverflowButtonSpacing: 12,
          actions: [
            AppButton(
              label: Labels.yesTerminate,
              onPressed: (){
                Navigator.of(context).pop(true);
              }
            ),
            AppButton(
              label: Labels.noProceed,
              onPressed: (){
                Navigator.of(context).pop(false);
              }
            ),
          ],
        );
      }
    ) ?? false;
  }
}