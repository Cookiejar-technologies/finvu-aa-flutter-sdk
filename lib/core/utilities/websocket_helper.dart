import 'dart:async';
import 'package:finvu_bank_pfm/presentation/models/user_info_model.dart';
import 'package:finvu_bank_pfm/presentation/providers/user_info_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'constants.dart';

class WebSocketHelper{
  static final WebSocketHelper _instance = WebSocketHelper._internal();
  static late Ref _ref;

  factory WebSocketHelper(Ref ref) {
    _ref = ref;
    return _instance;
  }

  static WebSocketChannel? _channel;
  static StreamSubscription? _stream;

  WebSocketHelper._internal(){
    init();
  }

  UserInfo get userInfo => _ref.read(userInfoProvider);

  init(){
    _channel ??= WebSocketChannel.connect(Uri.parse(Constants.websocketUrl(userInfo.devMode!)));
    _stream ??= _channel?.stream.asBroadcastStream().listen((event) { });
  }

  WebSocketChannel get channel {
    if(_channel == null){
      init();
    }
    return _channel!;
  }

  add(dynamic data) {
    if(_channel == null){
      init();
    }
    channel.sink.add(data);
  }

  StreamSubscription get stream => _stream!;

  logout(){
    stream.cancel();
    channel.sink.close();
    _channel = null;
    _stream = null;
  }

}