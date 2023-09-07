import '../../core/utilities/formats.dart';

class ConsentDetails{
  DateTime startTime;
  DateTime expireTime;
  String purpose;
  String fetchType;
  DateTime dateRangeFrom;
  DateTime dateRangeTo;
  String dataLife;
  String frequency;
  String consentHandle;
  List<String> consentTypes;
  List<String> consentDisplay;
  List<String> fiTypes;

  ConsentDetails({required this.startTime,
      required this.expireTime,
      required this.purpose,
      required this.fetchType,
      required this.dateRangeFrom,
      required this.dateRangeTo,
      required this.dataLife,
      required this.frequency,
      required this.consentHandle,
      required this.consentTypes,
      required this.consentDisplay,
      required this.fiTypes});

  factory ConsentDetails.fromJson(Map<String, dynamic> map) {
    return ConsentDetails(
      startTime: Formats.parseTimes(map['startTime']),
      expireTime: Formats.parseTimes(map['expireTime']),
      purpose: map['Purpose']['text'],
      fetchType: map['fetchType'],
      dateRangeFrom: Formats.parseTimes(map['DataDateTimeRange']['from']),
      dateRangeTo: Formats.parseTimes(map['DataDateTimeRange']['to']),
      dataLife: "${map['DataLife']['value']} ${map['DataLife']['unit']}",
      frequency: "${map['Frequency']['value']} ${map['Frequency']['unit']}",
      consentHandle: map['ConsentHandle'],
      consentTypes: map['consentTypes'].map<String>((e) => e.toString()).toList(),
      consentDisplay: map['consentDisplayDescriptions'].map<String>((e) => e.toString()).toList(),
      fiTypes: map['fiTypes'].map<String>((e) => e.toString()).toList(),
    );
  }
}