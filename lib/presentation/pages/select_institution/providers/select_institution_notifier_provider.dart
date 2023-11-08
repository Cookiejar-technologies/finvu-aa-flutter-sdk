import 'dart:convert';

import 'package:finvu_bank_pfm/core/utilities/constants.dart';
import 'package:finvu_bank_pfm/core/utilities/formats.dart';
import 'package:finvu_bank_pfm/core/utilities/header_builder.dart';
import 'package:finvu_bank_pfm/presentation/models/bank_model.dart';
import 'package:finvu_bank_pfm/presentation/providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utilities/snack_bar.dart';
import '../../../../core/utilities/utils.dart';
import '../../../../core/utilities/websocket_helper.dart';
import '../../../models/account_model.dart';

final selectInstitutionNotifierProvider = ChangeNotifierProvider<SelectInstitutionNotifier>((ref) => SelectInstitutionNotifier(ref));

class SelectInstitutionNotifier extends ChangeNotifier{
  final Ref _ref;
  SelectInstitutionNotifier(this._ref);

  String get mobileNo => _ref.read(userInfoProvider).mobileNo!;

  List<Bank> _banks = [];
  List<Bank> get banks => _banks;
  set banks(List<Bank> val){
    _banks = val;
    notifyListeners();
  }

  Bank? _selectedBank;
  Bank? get selectedBank => _selectedBank;
  set selectedBank(Bank? val){
    _selectedBank = val;
    notifyListeners();
  }

  List<Account> _accounts = [];
  List<Account> get accounts => _accounts;
  set accounts(List<Account> val){
    _accounts = val;
    notifyListeners();
  }

  getDiscoveredAccounts(BuildContext context, VoidCallback onDone){
    Map<String, dynamic> body = {
      "header": HeaderBuilder(_ref).wsHeader(Constants.discoverURN),
      "payload": {
        "ver": Constants.version,
        "timestamp": Formats.formatZ(DateTime.now()),
        "txnid": const Uuid().v4(),
        "Customer": {
          // "id": Constants.userId(mobileNo),
          "id": _ref.read(userInfoProvider).userId,
          "Identifiers": [
            {
              "category": "STRONG",
              "type": "MOBILE",
              "value": mobileNo
            }
          ]
        },
        "FIPDetails": {
          "fipId": selectedBank!.fipId,
          "fipName": selectedBank!.fipName
        },
        "FITypes": [
          "DEPOSIT",
          "RECURRING_DEPOSIT",
          "TERM-DEPOSIT"
        ]
      }
    };

    WebSocketHelper().channel.sink.add(jsonEncode(body));

    WebSocketHelper().stream.onData((event) {
      // print("Discover accounts");
      // print(event);
      final data = jsonDecode(event);
      if (Utils.isSuccess(data)) {
        List rawAccounts =  data['payload']["DiscoveredAccounts"];
        // print("rawAccounts");
        // print(rawAccounts);
        accounts = rawAccounts.map((e) => Account.fromJson(e)).toList();
        if (accounts.isNotEmpty) {
          onDone();
        }else{
          AppSnackBar.show("No Accounts found", context);
        }
      }else if(data['payload']['status'] == "RECORD-NOT-FOUND"){
        //"message":"No Accounts found."
        AppSnackBar.show(data['payload']['message'], context);
      }else{
        AppSnackBar.show(data['payload']['message'], context);
      }
    });
  }

  clear(){
    _selectedBank = null;
    _accounts = [];
  }
}