import 'ramp.dart';
import 'dart:io';

void main() async {
  Ramp ramp = Ramp();
  print('Prislonite karticu');
  String? input = stdin.readLineSync();
  ramp.setState(input);
  await ramp.printOutputData();
//  ramp.dispose();
}
