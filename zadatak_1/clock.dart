part 'clock_state.dart';

class Clock {
  DateTime _time = DateTime.now();
  State _state;
  Clock({required State state}) : _state = state;

  void setState(String input) {
    if (input == '1') {
      _toggleBlinking();
    } else if (input == '2') {
      _increment();
    } else if (input == '12') {
      _state = EditingCompleted(time: _time);
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

  State get getState => _state;
  void _increment() {
    if (_state is BlinkHourState) {
      _time = _time.add(Duration(hours: 1));
      _state = BlinkHourState(time: _time);
    } else if (_state is BlinkMinuteState) {
      _time = _time.add(Duration(minutes: 1));
      _state = BlinkMinuteState(time: _time);
    } else if (_state is BlinkSecondState) {
      _time = _time.add(Duration(seconds: 1));
      _state = BlinkSecondState(time: _time);
    }
  }
}
