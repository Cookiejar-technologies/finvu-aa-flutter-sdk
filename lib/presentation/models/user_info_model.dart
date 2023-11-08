class UserInfo{
  String? mobileNo;
  String? authToken;
  String? handleId;
  String? sid;
  String? userId;

  UserInfo({this.mobileNo, this.authToken, this.handleId, this.sid, this.userId});

  String get encodedMobileNo => mobileNo?.replaceRange(0, 6, "XXXXXX") ?? "";
}