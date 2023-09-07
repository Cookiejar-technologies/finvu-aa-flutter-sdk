import 'dart:convert';
import 'dart:developer';
import 'package:finvu_bank_pfm/core/utilities/constants.dart';
import 'package:finvu_bank_pfm/core/utilities/header_builder.dart';
import 'package:finvu_bank_pfm/presentation/models/bank_model.dart';
import 'package:finvu_bank_pfm/presentation/models/user_info_model.dart';
import 'package:finvu_bank_pfm/presentation/pages/auth/providers/auth_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/pages/select_institution/providers/select_institution_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/providers/user_info_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final repositoryProvider = Provider((ref) => Repository(ref));

final consentProvider = FutureProvider((ref)=>ref.read(repositoryProvider).getConsent());

class Repository {
  final Ref _ref;
  Repository(this._ref);

  String get mobileNo => _ref.read(userInfoProvider).mobileNo!;
  AuthNotifier get auth => _ref.read(authNotifierProvider);
  SelectInstitutionNotifier get selectInstitute => _ref.read(selectInstitutionNotifierProvider);
  UserInfo get userInfo => _ref.read(userInfoProvider);
  String? _authToken;

  Future<String> consentLogin()async{

    Map<String, dynamic> body = {
      "header": HeaderBuilder.postHeader(),
      "body":{
        "userId": "channel@dhanaprayoga",
        "password": "7777"
      }
    };

    http.Response res = await http.post(
      Uri.parse(Constants.login),
      headers:HeaderBuilder.defaultHeader(),
      body: jsonEncode(body)
    );
    if(res.statusCode == 200){
      final bodyDecode = jsonDecode(res.body);
      return bodyDecode['body']['token'];
    }else{
      /// 401 if token is expired
      throw Exception();
    }
  }

  Future<String> consentRequestPlus()async{

    Map<String, dynamic> body = {
      "header": HeaderBuilder.postHeader(),
      "body": {
        "custId": Constants.userId(mobileNo),
        "consentDescription": "Wealth Management Service",
        "templateName": "FINVUDEMO_TESTING",
        "userSessionId": "sessionid123",
        "redirectUrl": "https://google.co.in",
        "fip" : [],
        "ConsentDetails" : {

        }
      }
    };

    http.Response res = await http.post(
      Uri.parse(Constants.consentRequestPlus),
      headers: HeaderBuilder.authHeader(_authToken!),
      body: jsonEncode(body)
    );
    if(res.statusCode == 200){
      final bodyDecode = jsonDecode(res.body);
      return bodyDecode['body']['ConsentHandle'];
    }else{
      throw Exception();
    }
  }

  Future<List<Bank>> getFIP()async{
    http.Response res = await http.get(
      Uri.parse(Constants.fips),
      headers: HeaderBuilder.authHeader(_authToken!)
    );
    if(res.statusCode == 200){
      try {
        final bodyDecode = jsonDecode(res.body);
        List<Bank> banks = bodyDecode['body'].map<Bank>((e) => Bank.fromJson(e)).toList();
        return banks;
      } catch (e) {
        throw Exception();
      }
    }else{
      throw Exception();
    }
  }

  Future<String> getConsent()async{
    try {
      _authToken = await consentLogin();
      String handleId = await consentRequestPlus();
      List<Bank> banks = await getFIP();
      log("Authentication successful & Consent obtained");
      _ref.read(userInfoProvider.notifier).state.handleId = handleId;
      // userInfo.handleId = handleId;
      selectInstitute.banks = banks;
      auth.sendOtp();
      return handleId;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}