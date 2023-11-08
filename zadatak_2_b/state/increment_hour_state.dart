import 'increment_state.dart';

class IncrementHourState extends IncrementState {
  IncrementHourState({required super.date});

  @override
  void increment() {
    date = date.add(Duration(hours: 1));
  }
}
