part 'clock_state.dart';

class Clock {
  DateTime _time = DateTime.now();
  State _state;
  Clock({required State state}) : _state = state;

  void setState(String input) {
    if (input == '1') {
      _toggleBlinking();
    } else if (input == '2') {
      _convertState();
      _increment();
    } else if (input == '12') {
      _state = StopBlinkingState(time: _time);
    }
  }

  void _toggleBlinking() {
    if (_state is BlinkMinuteState) {
      _state = BlinkSecondState(time: _time);
    } else if (_state is BlinkHourState) {
      _state = BlinkMinuteState(time: _time);
    } else {
      _state = BlinkHourState(time: _time);
    }
  }

  void _convertState() {
    switch (_state.runtimeType) {
      case BlinkHourState:
        _state = IncrementHourState(time: _time);
        break;
      case BlinkMinuteState:
        _state = IncrementMinuteState(time: _time);
        break;
      case BlinkSecondState:
        _state = IncrementSecondState(time: _time);
        break;
      default:
    }
  }

  State get getState => _state;
  void _increment() {
    if (_state is IncrementHourState) {
      _time = _time.add(Duration(hours: 1));
      print(_state.runtimeType);
      _state = BlinkHourState(time: _time);
    } else if (_state is IncrementMinuteState) {
      _time = _time.add(Duration(minutes: 1));
      print(_state.runtimeType);
      _state = BlinkMinuteState(time: _time);
    } else if (_state is IncrementSecondState) {
      _time = _time.add(Duration(seconds: 1));
      print(_state.runtimeType);
      _state = BlinkSecondState(time: _time);
    }
  }
}
