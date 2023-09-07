import 'package:finvu_bank_pfm/core/utilities/constants.dart';

class Utils{
  static bool isSuccess(Map map){
    return map['payload']['status'] == Constants.success;
  }

  static bool isSend(Map map){
    return map['payload']['status'] == Constants.send;
  }
}