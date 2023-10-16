import 'dart:io';

import 'clock.dart';

void main() {
  Clock clock = Clock(state: BlinkHourState(time: DateTime.now()));
  State state = clock.getState;
  do {
    print(
        'Current time: ${state.time.hour}:${state.time.minute}:${state.time.second}');
    clock.setState(stdin.readLineSync()!);
    state = clock.getState;
    if (state is BlinkHourState) {
      print('Blinking time: -:${state.time.minute}:${state.time.second}');
    } else if (state is BlinkMinuteState) {
      print('Blinking time: ${state.time.hour}:-:${state.time.second}');
    } else if (state is BlinkSecondState) {
      print('Blinking time: ${state.time.hour}:${state.time.minute}:-');
    }
  } while (clock.getState is! EditingCompleted);
}
