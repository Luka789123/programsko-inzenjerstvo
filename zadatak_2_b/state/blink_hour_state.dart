import 'state.dart';

class BlinkHourState extends State {
  BlinkHourState({required super.date});

  @override
  String printAction() => '-:${date.minute}:${date.second}';
}
