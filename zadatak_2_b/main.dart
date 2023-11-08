import 'dart:io';

import 'clock.dart';

void main(List<String> args) {
  Clock clock = Clock();
  do {
    String input = stdin.readLineSync() ?? '';
    clock.setState(input);
  } while (!clock.stopInput);
}
