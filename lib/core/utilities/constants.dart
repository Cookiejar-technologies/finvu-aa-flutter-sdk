class Constants{
  static const String devVaseUrl = "https://dhanaprayoga.fiu.finfactor.in/finsense/API/V2/";
  static const String baseUrl = "https://canarabank.fiulive.finfactor.co.in/finsense/API/V2/";
  // static const String login = "${baseUrl}User/Login";
  // static const String consentRequestPlus = "${baseUrl}ConsentRequestPlus";
  static String fips(bool devMode) => "${devMode ? devVaseUrl : baseUrl}fips";

  static const String devWebsocketUrl = "wss://webvwdev.finvu.in/consentapi";
  static const String prodWebsocketUrl = "wss://webvwlive.finvu.in/consentapi";
  static String websocketUrl(bool devMode) => devMode ? devWebsocketUrl : prodWebsocketUrl;
  static String websocketWebApiUrl(bool devMode) => devMode ? "wss://webvwdev.finvu.in/webapi" : "wss://webvwlive.finvu.in/webapi";

  static const String userIdSuffix = "@finvu";
  static String userId(String mobileNo) => "$mobileNo$userIdSuffix";
  static const String channelId = "finsense";
  static const String version = "1.1.2";
  static const String devEntityId = "fiu@canarabankuat";
  static const String prodEntityId = "fiulive@canarabank";
  static String entityId(bool devMode) => devMode ? devEntityId : prodEntityId;

  ///URN Types
  static const String sendOtpURN = "urn:finvu:in:app:req.loginOtp.01";
  static const String verifyOtpURN = "urn:finvu:in:app:req.loginOtpVerify.01";
  static const String discoverURN = "urn:finvu:in:app:req.discover.01";
  static const String accLinkingURN = "urn:finvu:in:app:req.linking.01";
  static const String verifyAccLinkingURN = "urn:finvu:in:app:req.confirm-token.01";
  static const String consentDetailsURN = "urn:finvu:in:app:req.consentRequestDetails.01";
  static const String consentApprovalURN = "urn:finvu:in:app:req.accountConsentRequest.01";
  static const String userLinkedURN = "urn:finvu:in:app:req.userLinkedAccount.01";
  static const String logoutURN = "urn:finvu:in:app:req.logout.01";
  static const String configURN = "urn:finvu:in:app:req.entitySdkConfig.01";

  ///Enums
  static const String accept = "ACCEPT";
  static const String deny = "DENY";
  static const String success = "SUCCESS";
  static const String send = "SEND";

  static const List<String> preferredFips = ["sbi-fip","PNB-FIP","BARBFIP","HDFC-FIP","ICICI-FIP","AXIS001"];
  static List<String> bankList = ["State Bank of India","Kotak Bank","ICICI Bank","Bank Of India","Bank Of Maharashtra"];
}