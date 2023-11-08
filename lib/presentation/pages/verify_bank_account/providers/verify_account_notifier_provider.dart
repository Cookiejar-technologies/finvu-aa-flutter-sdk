import 'dart:convert';
import 'dart:developer';
import 'package:finvu_bank_pfm/core/utilities/constants.dart';
import 'package:finvu_bank_pfm/core/utilities/formats.dart';
import 'package:finvu_bank_pfm/core/utilities/header_builder.dart';
import 'package:finvu_bank_pfm/core/utilities/snack_bar.dart';
import 'package:finvu_bank_pfm/core/utilities/utils.dart';
import 'package:finvu_bank_pfm/core/utilities/websocket_helper.dart';
import 'package:finvu_bank_pfm/presentation/models/account_model.dart';
import 'package:finvu_bank_pfm/presentation/models/linked_account_model.dart';
import 'package:finvu_bank_pfm/presentation/pages/select_institution/providers/select_institution_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final verifyAccountNotifierProvider = ChangeNotifierProvider((ref) => VerifyAccountNotifier(ref));

class VerifyAccountNotifier extends ChangeNotifier{
  final Ref _ref;
  VerifyAccountNotifier(this._ref);

  SelectInstitutionNotifier get selectInstNotifier => _ref.read(selectInstitutionNotifierProvider);

  List<LinkedAccount>? linkedAccounts;
  String? _otpRef;
  String get mobileNo => _ref.read(userInfoProvider).mobileNo!;

  String? _otp;
  String get otp => _otp ?? "";
  set otp(String val){
    _otp = val;
    notifyListeners();
  }

  List<Account> _selectedAccounts = [];
  List<Account> get selectedAccounts => _selectedAccounts;
  set selectedAccounts(List<Account> val){
    _selectedAccounts = val;
    notifyListeners();
  }

  addAccount(Account acc){
    selectedAccounts.add(acc);
    notifyListeners();
  }

  removeAccount(Account acc){
    selectedAccounts.remove(acc);
    notifyListeners();
  }

  accLinking({required BuildContext context, required VoidCallback onOtpSent, required VoidCallback ifVerified}){
    Map<String, dynamic> body = {
      "header": HeaderBuilder(_ref).wsHeader(Constants.accLinkingURN),
      "payload": {
        "ver": Constants.version,
        "timestamp": Formats.formatZ(DateTime.now()),
        "txnid": const Uuid().v4(),
        "FIPDetails": {
          "fipId": selectInstNotifier.selectedBank!.fipId,
          "fipName": selectInstNotifier.selectedBank!.fipName
        },
        "Customer": {
          // "id": Constants.userId(mobileNo),
          "id": _ref.read(userInfoProvider).userId,
          "Accounts": selectedAccounts.map((e) => e.toJson()).toList()
        }
      }
    };

    // print(body);

    WebSocketHelper().channel.sink.add(jsonEncode(body));

    WebSocketHelper().stream.onData((event) {
      // print("Acc Linking start");
      // print(event);
      final data = jsonDecode(event);
      if (Utils.isSuccess(data)) {
        _otpRef = data['payload']['RefNumber'];
        onOtpSent();
      }else if(data['payload']['RefNumber'] == null){
        //ge user linked accounts and get linkRefNumber
        getUserLinkedAccounts((){
          if(selectedAccounts.where((e) => e.linkRefNumber == null).isEmpty){
            AppSnackBar.show(data['payload']['message'], context);
            ifVerified();
          }else{
            final accs = selectedAccounts.where((e) => e.linkRefNumber == null).map((e) => e.maskedAccNumber).join(", ");
            AppSnackBar.show("One or more selected accounts are not verified and linked: $accs", context);
          }
        });
        // "status":"FAILURE","message":"You have already linked this account(s): XXXXX2396  "

        //If account is already linked, dont show OTP bottom sheet. Navigate to consent page
      }else{
        // "status":"FAILURE","message":"Token incorrect."
        AppSnackBar.show(data['payload']['message'], context);
      }
    });
  }

  getUserLinkedAccounts(VoidCallback onDone){
    Map<String, dynamic> body = {
      "header": HeaderBuilder(_ref).wsHeader(Constants.userLinkedURN),
      "payload": {
        // "userId":Constants.userId(mobileNo)
        "userId": _ref.read(userInfoProvider).userId
      }
    };

    WebSocketHelper().channel.sink.add(jsonEncode(body));

    WebSocketHelper().stream.onData((event) {
      // print("User linked accounts");
      // log(event);
      final data = jsonDecode(event);
      if (Utils.isSuccess(data)) {
        linkedAccounts = data['payload']['LinkedAccounts'].map<LinkedAccount>((e) => LinkedAccount.fromJson(e)).toList();
        if (linkedAccounts != null) {
          for (var e in linkedAccounts!) {
            if (selectedAccounts.where((acc) => acc.accRefNumber == e.accRefNumber).isNotEmpty) {
              selectedAccounts.where((acc) => acc.accRefNumber == e.accRefNumber).first.linkRefNumber = e.linkRefNumber;
            }
          }
          // print("Yoooo! Got the linkRefNo Bro");
          onDone();
        }
      }
    });
  }

  verifyAccLinking(BuildContext context, VoidCallback onDone){
    Map<String, dynamic> body = {
      "header": HeaderBuilder(_ref).wsHeader(Constants.verifyAccLinkingURN),
      "payload": {
        "ver": Constants.version,
        "timestamp": Formats.formatZ(DateTime.now()),
        "txnid": const Uuid().v4(),
        "AccountsLinkingRefNumber": _otpRef,
        "token": otp
      }
    };

    // print(body);

    WebSocketHelper().channel.sink.add(jsonEncode(body));

    WebSocketHelper().stream.onData((event) {
      // print("Acc Linking verification start");
      // print(event);
      final data = jsonDecode(event);
      if (Utils.isSuccess(data)) {
        final List accLinkDetails = data['payload']['AccLinkDetails'];
        for (var e in accLinkDetails) {
          selectedAccounts.where((acc) => acc.accRefNumber == e["accRefNumber"]).first.linkRefNumber = e['linkRefNumber'];
        }
        onDone();
      }else{
        // "status":"FAILURE","message":"Otp validation failed."
        AppSnackBar.show(data['payload']['message'], context);
      }
    });
  }

  clear(){
    _otp = null;
    _otpRef = null;
  }
}