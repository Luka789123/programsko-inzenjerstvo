import '../state/state.dart';

abstract class Context<T extends State> {
  T getCurrentState();
  Stream<T> output();
  void close();
}
