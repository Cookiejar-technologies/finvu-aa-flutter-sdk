import 'package:finvu_bank_pfm/core/utilities/constants.dart';
import 'package:finvu_bank_pfm/core/utilities/formats.dart';
import 'package:finvu_bank_pfm/presentation/models/user_info_model.dart';
import 'package:finvu_bank_pfm/presentation/providers/user_info_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class HeaderBuilder{
  Ref? ref;
  HeaderBuilder(this.ref);

  UserInfo? get userInfo => ref?.read(userInfoProvider);

  static Map<String,String> defaultHeader(){
    return {
      "Content-Type":"application/json"
    };
  }

  static Map<String,String> authHeader(String authToken){
    return {
      "Content-Type":"application/json",
      "Authorization": "Bearer $authToken"
    };
  }

  static Map<String, dynamic> postHeader(){
    return {
      "ts":  Formats.formatISOTime(DateTime.now()),
      "channelId": Constants.channelId,
      "rid": const Uuid().v4()
    };
  }

  Map<String, dynamic> wsHeader(String type){
    return {
      "mid": const Uuid().v4(),
      "ts": Formats.formatISOTime(DateTime.now()),
      "sid": userInfo!.sid,
      "dup": false,
      "type": type
    };
  }

  Map<String, dynamic> emptyWsHeader(String type){
    return {
      "mid": const Uuid().v4(),
      "ts": Formats.formatISOTime(DateTime.now()),
      "sid": "",
      "dup": false,
      "type": type
    };
  }

}