import 'state.dart';

class BlinkSecondState extends State {
  BlinkSecondState({required super.date});

  @override
  String printAction() => '${date.hour}:${date.minute}:-';
}
