class LinkedAccount{
  final String fipId;
  final String fipName;
  final String linkRefNumber;
  final String accType;
  final String accRefNumber;
  final String maskedAccNumber;
  final String FIType;

  LinkedAccount({
    required this.fipId,
    required this.fipName,
    required this.linkRefNumber,
    required this.accType,
    required this.accRefNumber,
    required this.maskedAccNumber,
    required this.FIType});

  factory LinkedAccount.fromJson(Map<String, dynamic> map) {
    return LinkedAccount(
      fipId: map['fipId'],
      fipName: map['fipName'],
      linkRefNumber: map['linkRefNumber'],
      accType: map['accType'],
      accRefNumber: map['accRefNumber'],
      maskedAccNumber: map['maskedAccNumber'],
      FIType: map['FIType'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'accType': accType,
  //     'accRefNumber': accRefNumber,
  //     'maskedAccNumber': maskedAccNumber,
  //     'FIType': FIType,
  //   };
  // }
}