import 'package:finvu_bank_pfm/presentation/models/user_info_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userInfoProvider = StateProvider<UserInfo>((ref) {
  return UserInfo();
},);