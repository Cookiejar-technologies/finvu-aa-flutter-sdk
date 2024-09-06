import 'dart:convert';
import 'dart:developer';
import 'package:finvu_bank_pfm/core/utilities/constants.dart';
import 'package:finvu_bank_pfm/core/utilities/header_builder.dart';
import 'package:finvu_bank_pfm/presentation/models/bank_model.dart';
import 'package:finvu_bank_pfm/presentation/models/user_info_model.dart';
import 'package:finvu_bank_pfm/presentation/pages/auth/providers/auth_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/pages/select_institution/providers/select_institution_notifier_provider.dart';
import 'package:finvu_bank_pfm/presentation/providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final repositoryProvider = Provider((ref) => Repository(ref));

final consentProvider = FutureProvider((ref)=>ref.read(repositoryProvider).getConsent());

class Repository {
  final Ref _ref;
  Repository(this._ref);

  String get mobileNo => _ref.read(userInfoProvider).mobileNo!;
  String get authToken => _ref.read(userInfoProvider).authToken!;
  AuthNotifier get auth => _ref.read(authNotifierProvider);
  SelectInstitutionNotifier get selectInstitute => _ref.read(selectInstitutionNotifierProvider);
  UserInfo get userInfo => _ref.read(userInfoProvider);
  VoidCallback? onDone;
  VoidCallback? onInteraction;

  Future<List<Bank>> getFIP()async{
    http.Response res = await http.get(
      Uri.parse(Constants.fips(userInfo.devMode!)),
      headers: HeaderBuilder.authHeader(authToken)
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

  Future<void> getConsent()async{
    try {
      List<Bank> banks = await getFIP();
      log("Authentication successful & Consent obtained");
      selectInstitute.banks = banks;
      auth.sendOtp();
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}