import 'package:finvu_bank_pfm/finvu_bank_pfm.dart';

class UserInfo{
  String? mobileNo;
  String? authToken;
  String? handleId;
  String? sid;
  String? userId;
  String? pan;
  bool? devMode;
  AAType? aaType;

  UserInfo({this.mobileNo, this.authToken, this.handleId, this.sid, this.userId, this.devMode, this.pan, this.aaType});

  String get encodedMobileNo => mobileNo?.replaceRange(0, 6, "XXXXXX") ?? "";

  bool get isDeposit => aaType! == AAType.deposit;
  bool get isMF => aaType! == AAType.mutualFund;
  bool get isEquity => aaType! == AAType.equity;
}