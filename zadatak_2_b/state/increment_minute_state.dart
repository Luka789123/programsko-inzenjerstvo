import 'increment_state.dart';

class IncrementMinuteState extends IncrementState {
  IncrementMinuteState({required super.date});

  @override
  void increment() {
    date = date.add(Duration(minutes: 1));
  }
}
