import 'package:finvu_bank_pfm/presentation/models/bank_model.dart';

class Account{
  final String accType;
  final String accRefNumber;
  final String maskedAccNumber;
  final String FIType;
  String? linkRefNumber;

  Account({required this.accType, required this.accRefNumber, required this.maskedAccNumber, required this.FIType, this.linkRefNumber});

  factory Account.fromJson(Map<String, dynamic> map) {
    return Account(
      accType: map['accType'],
      accRefNumber: map['accRefNumber'],
      maskedAccNumber: map['maskedAccNumber'],
      FIType: map['FIType'],
      linkRefNumber: null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accType': accType,
      'accRefNumber': accRefNumber,
      'maskedAccNumber': maskedAccNumber,
      'FIType': FIType,
    };
  }

  Map<String, dynamic> consentToJson(Bank selectedBank) {
    return {
      'accType': accType,
      'accRefNumber': accRefNumber,
      'maskedAccNumber': maskedAccNumber,
      'FIType': FIType,
      'linkRefNumber': linkRefNumber,
      'fipId': selectedBank.fipId,
      'fipName': selectedBank.fipName
    };
  }

  Map<String, dynamic> consentToJsonMf(String fipId, String fipName) {
    return {
      'accType': accType,
      'accRefNumber': accRefNumber,
      'maskedAccNumber': maskedAccNumber,
      'FIType': FIType,
      'linkRefNumber': linkRefNumber,
      'fipId': fipId,
      'fipName': fipName
    };
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Account &&
    runtimeType == other.runtimeType &&
    accRefNumber == other.accRefNumber &&
    maskedAccNumber == other.maskedAccNumber;

  @override
  int get hashCode => accRefNumber.hashCode;
}