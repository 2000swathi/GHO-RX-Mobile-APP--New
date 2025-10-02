import 'dart:async';

class OTPTimer {
  late int _remainingSeconds;
  Timer? _timer;

  void start({required int seconds, void Function(int remaining)? onTick, void Function()? onFinish}) {
    _remainingSeconds = seconds;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingSeconds--;
      if (onTick != null) onTick(_remainingSeconds);

      if (_remainingSeconds <= 0) {
        timer.cancel();
        if (onFinish != null) onFinish();
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }

  void reset({required int seconds, void Function(int remaining)? onTick}) {
    stop();
    _remainingSeconds = seconds;
    if (onTick != null) onTick(_remainingSeconds);
  }

  int get remainingSeconds => _remainingSeconds;
  bool get isActive => _timer?.isActive ?? false;
  
}