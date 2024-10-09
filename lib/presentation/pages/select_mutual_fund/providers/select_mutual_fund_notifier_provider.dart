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
import 'package:finvu_bank_pfm/presentation/models/user_info_model.dart';
import 'package:finvu_bank_pfm/presentation/pages/verify_bank_account/providers/verify_account_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';


final selectMfNotifierProvider = ChangeNotifierProvider((ref) => SelectMutualFundNotifier(ref));

class SelectMutualFundNotifier extends ChangeNotifier {
  final Ref _ref;

  SelectMutualFundNotifier(this._ref);

  UserInfo get userInfo => _ref.read(userInfoProvider);

  List<LinkedAccount>? linkedAccounts;

  List<Account> _accounts = [];
  List<Account> get accounts => _accounts;
  set accounts(List<Account> val){
    _accounts = val;
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

  String? _otpRef;
  String get fipId => userInfo.devMode! ? "fip@finrepo" : "CDSLFIP";
  String get fipName => userInfo.devMode! ? "Finrepo" : "Central Depository Services Limited";

  getDiscoveredMfAccounts(BuildContext context){
    Map<String, dynamic> body = {
      "header": HeaderBuilder(_ref).wsHeader(Constants.discoverURN),
      "payload": {
        "ver": Constants.version,
        "timestamp": Formats.formatZ(DateTime.now()),
        "txnid": const Uuid().v4(),
        "Customer": {
          "id": _ref.read(userInfoProvider).userId,
          "Identifiers": [
            {
              "category": "STRONG",
              "type": "MOBILE",
              "value": userInfo.mobileNo
            },
            {
              "category": "WEAK",
              "type": "PAN",
              "value": userInfo.pan
            }
          ]
        },
        "FIPDetails": {
          "fipId": fipId,
          "fipName": fipName
        },
        "FITypes": [
          "MUTUAL_FUNDS"
        ]
      }
    };

    WebSocketHelper(_ref).channel.sink.add(jsonEncode(body));

    WebSocketHelper(_ref).stream.onData((event) {
      print("MF DiscoveredAccounts");
      print(event);
      final data = jsonDecode(event);
      if (Utils.isSuccess(data)) {
        List rawAccounts =  data['payload']["DiscoveredAccounts"];
        accounts = rawAccounts.map((e) => Account.fromJson(e)).toList();
        // if (accounts.isNotEmpty) {
        //   onDone();
        // }else{
        //   AppSnackBar.show("No Accounts found", context);
        // }
      }else if(data['payload']['status'] == "RECORD-NOT-FOUND"){
        //"message":"No Accounts found."
        AppSnackBar.show(data['payload']['message'], context);
      }else{
        AppSnackBar.show(data['payload']['message'], context);
      }
    });
  }

  mfAccLinking({required BuildContext context, required VoidCallback onOtpSent, required VoidCallback ifVerified}){
    getUserLinkedAccounts(() {
      List<Account> accountsTobeLinked = selectedAccounts.where((e) => e.linkRefNumber == null).toList();
      if (accountsTobeLinked.isEmpty) {
        ifVerified();
        return;
      }

      Map<String, dynamic> body = {
        "header": HeaderBuilder(_ref).wsHeader(Constants.accLinkingURN),
        "payload": {
          "ver": Constants.version,
          "timestamp": Formats.formatZ(DateTime.now()),
          "txnid": const Uuid().v4(),
          "FIPDetails": {
            "fipId": fipId,
            "fipName": fipName
          },
          "Customer": {
            // "id": Constants.userId(mobileNo),
            "id": _ref.read(userInfoProvider).userId,
            "Accounts": accountsTobeLinked
          }
        }
      };

      WebSocketHelper(_ref).channel.sink.add(jsonEncode(body));

      WebSocketHelper(_ref).stream.onData((event) {
        final data = jsonDecode(event);
        if (Utils.isSuccess(data)) {
          _otpRef = data['payload']['RefNumber'];
          onOtpSent();
        } else{
          AppSnackBar.show(data['payload']['message'], context);
        }
      });
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

    WebSocketHelper(_ref).channel.sink.add(jsonEncode(body));

    WebSocketHelper(_ref).stream.onData((event) {
      final data = jsonDecode(event);
      if (Utils.isSuccess(data)) {
        linkedAccounts = data['payload']['LinkedAccounts'].map<LinkedAccount>((e) => LinkedAccount.fromJson(e)).toList();
        if (linkedAccounts != null) {
          for (var e in linkedAccounts!) {
            if (selectedAccounts.where((acc) => acc.accRefNumber == e.accRefNumber).isNotEmpty) {
              selectedAccounts.where((acc) => acc.accRefNumber == e.accRefNumber).first.linkRefNumber = e.linkRefNumber;
            }
          }
        }
      }
      onDone();
    });
  }

  verifyAccLinking(BuildContext context, String otp, VoidCallback onDone){
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

    WebSocketHelper(_ref).channel.sink.add(jsonEncode(body));

    WebSocketHelper(_ref).stream.onData((event) {
      print("Acc Linking verification start");
      print(event);
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

  mfConsentApprovalReq(String accept, VoidCallback onDone){
    Map<String, dynamic> body = {
      "header": HeaderBuilder(_ref).wsHeader(Constants.consentApprovalURN),
      "payload": {
        "FIPDetails": [
          {
            "FIP": {
              "id": fipId,
            },
            "Accounts" : selectedAccounts.map((e) => e.consentToJsonMf(fipId, fipName)).toList()
          }
        ],
        "FIU": {
          "id": Constants.userId(userInfo.mobileNo!)
        },
        "ver": Constants.version,
        "consentHandleId": userInfo.handleId,
        "handleStatus": accept
      }
    };

    print(jsonEncode(body));

    WebSocketHelper(_ref).channel.sink.add(jsonEncode(body));

    WebSocketHelper(_ref).stream.onData((event) {
      print("Consent accept/reject Data");
      print(event);
      final dataRaw = jsonDecode(event);
      if (Utils.isSuccess(dataRaw)) {
        // dataRaw['payload']['fipConsentInfos'][0]['consentId'];
        // dataRaw['payload']['consentIntentId'];
        onDone();
      }
    });
  }
}