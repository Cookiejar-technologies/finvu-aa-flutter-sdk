import 'dart:async';
import 'dart:developer';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sessionProvider = ChangeNotifierProvider((ref) => SessionManager(ref));

class SessionManager extends ChangeNotifier{
  final Ref _ref;
  SessionManager(this._ref);

  RestartableTimer? timer;
  // Timer? heartBeat;

  init(int interval, int timeOut, /*Function(int) onInterval*/){
    if(timer != null) return;
    // heartBeat = Timer.periodic(Duration(seconds: interval), (timer) {
    //   onInterval(timer.tick*interval);
    // });
    timer = RestartableTimer(Duration(seconds: timeOut), (){
      timer!.cancel();
      // heartBeat!.cancel();
      notifyListeners();
      log("AA Flow Session Timed Out!");
    });
  }

  bool get isTimerActive => timer?.isActive ?? true;

  reset() {
    if (isTimerActive) {
      timer!.reset();
    }
  }

}