import 'dart:convert';
import 'dart:developer';
import 'package:finvu_bank_pfm/core/utilities/snack_bar.dart';
import 'package:finvu_bank_pfm/core/utilities/utils.dart';
import 'package:finvu_bank_pfm/presentation/models/user_info_model.dart';
import 'package:finvu_bank_pfm/presentation/pages/consent/providers/consent_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utilities/constants.dart';
import '../../../../core/utilities/header_builder.dart';
import '../../../../core/utilities/websocket_helper.dart';

final authNotifierProvider = ChangeNotifierProvider((ref) => AuthNotifier(ref));

class AuthNotifier extends ChangeNotifier{
  final Ref _ref;
  AuthNotifier(this._ref);

  ConsentNotifier get consentNotifier => _ref.read(consentNotifierProvider);
  UserInfo get userInfo => _ref.read(userInfoProvider);

  String? _otpRef;

  String? _otp;
  String get otp => _otp ?? "";
  set otp(String val){
    _otp = val;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool val){
    _loading = val;
    notifyListeners();
  }

  sendOtp(){
    Map<String, dynamic> body = {
      "header": HeaderBuilder(_ref).wsHeader(Constants.sendOtpURN),
      "payload": {
        "username": Constants.userId(userInfo.mobileNo!),
        "mobileNum": userInfo.mobileNo,
        "handleId": userInfo.handleId
      }
    };

    WebSocketHelper().channel.sink.add(jsonEncode(body));
    WebSocketHelper().stream.onData((event) {
      // print("Login");
      // print(event);
      final data = jsonDecode(event);
      if (Utils.isSend(data)) {
        _otpRef = data['payload']['otpReference'];
      }
    });
  }

  verifyOtp(BuildContext context, VoidCallback onDone){
    loading = true;
    Map<String, dynamic> body = {
      "header": HeaderBuilder(_ref).wsHeader(Constants.verifyOtpURN),
      "payload": {
        "otpReference": _otpRef,
        "otp": otp
      }
    };

    WebSocketHelper().channel.sink.add(jsonEncode(body));
    WebSocketHelper().stream.onData((event) {
      // print("Verify OTP");
      // print(event);
      final data = jsonDecode(event);
      if (Utils.isSuccess(data)) {
        _ref.read(userInfoProvider.notifier).state.sid = data['header']['sid'];
        if(userInfo.sid != null){
          consentNotifier.consentRequestDetails();
          onDone();
        }
      }else{
        /// "status":"FAILURE","message":"Otp validation failed."
        AppSnackBar.show(data['payload']['message'], context);
      }
      loading = false;
    });
  }

  logout(VoidCallback onDone){
    Map<String, dynamic> body = {
      "header": HeaderBuilder(_ref).wsHeader(Constants.logoutURN),
      "payload": {
        "userId":Constants.userId(userInfo.mobileNo!)
      }
    };

    WebSocketHelper().channel.sink.add(jsonEncode(body));

    WebSocketHelper().stream.onData((event) {
      // print("User logout");
      // log(event);
      final data = jsonDecode(event);
      if (Utils.isSuccess(data)) {
        onDone();
        WebSocketHelper().stream.cancel();
        WebSocketHelper().channel.sink.close();
      }
    });

  }

}