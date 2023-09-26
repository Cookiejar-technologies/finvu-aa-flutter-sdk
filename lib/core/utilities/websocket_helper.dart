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
    _channel ??= WebSocketChannel.connect(Uri.parse(Constants.websocketUrl));
    _stream ??= _channel?.stream.asBroadcastStream().listen((event) { });
  }

  WebSocketChannel get channel => _channel!;

  add(dynamic data) => channel.sink.add(data);

  StreamSubscription get stream => _stream!;

}