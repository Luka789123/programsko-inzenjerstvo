import 'state.dart';

abstract class IncrementState extends State {
  IncrementState({required super.date});

  void increment();

  @override
  String printAction() {
    increment();
    return '${date.hour}:${date.minute}:${date.second}';
  }
}
