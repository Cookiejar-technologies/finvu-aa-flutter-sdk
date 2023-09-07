import 'dart:convert';
import 'dart:developer';

import 'package:finvu_bank_pfm/core/utilities/constants.dart';
import 'package:finvu_bank_pfm/core/utilities/header_builder.dart';
import 'package:finvu_bank_pfm/core/utilities/utils.dart';
import 'package:finvu_bank_pfm/core/utilities/websocket_helper.dart';
import 'package:finvu_bank_pfm/presentation/models/account_model.dart';
import 'package:finvu_bank_pfm/presentation/models/bank_model.dart';
import 'package:finvu_bank_pfm/presentation/models/details_model.dart';
import 'package:finvu_bank_pfm/presentation/models/user_info_model.dart';
import 'package:finvu_bank_pfm/presentation/pages/select_institution/providers/select_institution_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/pages/verify_bank_account/providers/verify_account_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final consentNotifierProvider = ChangeNotifierProvider((ref) => ConsentNotifier(ref));

class ConsentNotifier extends ChangeNotifier{
  final Ref _ref;
  ConsentNotifier(this._ref);

  SelectInstitutionNotifier get selectInstitute => _ref.read(selectInstitutionNotifierProvider);
  VerifyAccountNotifier get verifyAcc => _ref.read(verifyAccountNotifierProvider);
  Bank get selectedBank => selectInstitute.selectedBank!;
  List<Account> get selectedAccounts => verifyAcc.selectedAccounts;

  UserInfo get userInfo => _ref.read(userInfoProvider);

  ConsentDetails? _details;
  ConsentDetails? get details => _details;
  set details(ConsentDetails? val){
    _details = val;
    notifyListeners();
  }

  consentRequestDetails(){
    Map<String, dynamic> body = {
      "header": HeaderBuilder(_ref).wsHeader(Constants.consentDetailsURN),
      "payload": {
        "consentHandleId": userInfo.handleId,
        "userId": Constants.userId(userInfo.mobileNo!)
      }
    };

    WebSocketHelper().channel.sink.add(jsonEncode(body));

    WebSocketHelper().stream.onData((event) {
      print("Consent Request Data");
      log(event);
      final dataRaw = jsonDecode(event);
      if (Utils.isSuccess(dataRaw)) {
        details = ConsentDetails.fromJson(dataRaw['payload']);
      }
    });
  }

  consentApprovalReq(String accept, VoidCallback onDone){
    Map<String, dynamic> body = {
      "header": HeaderBuilder(_ref).wsHeader(Constants.consentApprovalURN),
      "payload": {
        "FIPDetails": [
          {
            "FIP": {
              "id": selectedBank.fipId,
            },
            "Accounts" : selectedAccounts.map((e) => e.consentToJson(selectedBank)).toList()
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

    log(jsonEncode(body));

    WebSocketHelper().channel.sink.add(jsonEncode(body));

    WebSocketHelper().stream.onData((event) {
      print("Consent accept/reject Data");
      log(event);
      final dataRaw = jsonDecode(event);
      if (Utils.isSuccess(dataRaw)) {
        dataRaw['payload']['fipConsentInfos'][0]['consentId'];
        dataRaw['payload']['consentIntentId'];
        onDone();
      }
    });
  }

}