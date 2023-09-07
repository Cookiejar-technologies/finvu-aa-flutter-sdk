class UserInfo{
  String? mobileNo;
  String? authToken;
  String? handleId;
  String? sid;

  UserInfo({this.mobileNo, this.authToken, this.handleId, this.sid});

  String get encodedMobileNo => mobileNo?.replaceRange(0, 6, "XXXXXX") ?? "";
}