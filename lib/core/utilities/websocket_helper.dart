import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'constants.dart';

class WebSocketHelper{
  static final WebSocketHelper _instance = WebSocketHelper._internal();

  factory WebSocketHelper() {
    return _instance;
  }

  static WebSocketChannel? _channel;
  static StreamSubscription? _stream;

  WebSocketHelper._internal(){
    init();
  }

  init(){
    _channel ??= WebSocketChannel.connect(Uri.parse(Constants.websocketUrl));
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