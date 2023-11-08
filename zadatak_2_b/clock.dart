import 'state/blink_hour_state.dart';
import 'state/blink_minute_state.dart';
import 'state/blink_second_state.dart';
import 'state/increment_hour_state.dart';
import 'state/increment_minute_state.dart';
import 'state/increment_second_state.dart';
import 'state/state.dart';

class Clock {
  bool _stopInput = false;
  DateTime _dateTime = DateTime.now();
  late State _currentState;
  Clock() {
    _currentState = BlinkHourState(date: _dateTime);
  }
  void setState(String? input) {
    switch (input) {
      case "1":
        _toggleBlinkState();
        _doAction();
        break;
      case "2":
        _increment();
        _doAction();
      case "12":
        _stopInput = true;
      default:
    }
  }

  void _toggleBlinkState() {
    if (_currentState is BlinkHourState) {
      _currentState = BlinkMinuteState(date: _dateTime);
    } else if (_currentState is BlinkMinuteState) {
      _currentState = BlinkSecondState(date: _dateTime);
    } else {
      _currentState = BlinkHourState(date: _dateTime);
    }
  }

  void _increment() {
    if (_currentState is BlinkHourState) {
      _currentState = IncrementHourState(date: _dateTime);
    } else if (_currentState is BlinkMinuteState) {
      _currentState = IncrementMinuteState(date: _dateTime);
    } else if (_currentState is BlinkSecondState) {
      _currentState = IncrementSecondState(date: _dateTime);
    }
  }

  void _doAction() => print(_currentState.printAction());
  bool get stopInput => _stopInput;
}
