import 'dart:io';

import 'clock.dart';

void main() {
  Clock clock = Clock(state: BlinkHourState(time: DateTime.now()));
  State state = clock.getState;
  do {
    clock.setState(stdin.readLineSync()!);
    state = clock.getState;
    if (state is BlinkHourState) {
      print('Time: -:${state.time.minute}:${state.time.second}');
    } else if (state is BlinkMinuteState) {
      print('Time: ${state.time.hour}:-:${state.time.second}');
    } else if (state is BlinkSecondState) {
      print('Time: ${state.time.hour}:${state.time.minute}:-');
    } else {
      print(
          'Time: ${state.time.hour}:${state.time.minute}:${state.time.second}');
    }
  } while (clock.getState is! StopBlinkingState);
}
