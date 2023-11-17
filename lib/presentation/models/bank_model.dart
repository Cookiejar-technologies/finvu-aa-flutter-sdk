import 'package:finvu_bank_pfm/core/utilities/constants.dart';

class Bank{
  String fipId;
  String fipName;
  String? code;
  String enable;
  List<String> fiTypes;
  String? entityIconUri;
  String? entityLogoUri;
  String? entityLogoWithNameUri;
  int otpLength;

  Bank({required this.fipId,
      required this.fipName,
      required this.code,
      required this.enable,
      required this.fiTypes,
      required this.entityIconUri,
      required this.entityLogoUri,
      required this.entityLogoWithNameUri,
      required this.otpLength});

  factory Bank.fromJson(Map<String, dynamic> map) {
    return Bank(
      fipId: map['fipId'],
      fipName: map['fipName'],
      code: map['code'],
      enable: map['enable'],
      fiTypes: map['fiTypes'].isEmpty ? <String>[] : map['fiTypes'].map<String>((e) => e.toString()).toList(),
      entityIconUri: map['entityIconUri'],
      entityLogoUri: map['entityLogoUri'],
      entityLogoWithNameUri: map['entityLogoWithNameUri'],
      otpLength: map['otpLength'] ?? 0,
    );
  }

  bool get enabled => enable == "Y";
  bool get bankIconNull => entityIconUri == null;
  bool get bankLogoNull => entityLogoUri == null;

  bool get isPreferred => Constants.preferredFips.contains(fipId);

}