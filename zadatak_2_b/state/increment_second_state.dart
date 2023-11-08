import 'increment_state.dart';

class IncrementSecondState extends IncrementState {
  IncrementSecondState({required super.date});

  @override
  void increment() {
    date = date.add(Duration(seconds: 1));
  }
}
