import 'state.dart';

class BlinkMinuteState extends State {
  BlinkMinuteState({required super.date});

  @override
  String printAction() => '${date.hour}:-:${date.second}';
}
