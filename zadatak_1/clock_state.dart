part of 'clock.dart';

/// Ishodištna apstrhatna klasa od koje se sva druga stanja naslijeđuju
sealed class State {
  //DateTime je Dart klasa koja se koristi za manipulaciju s vremenom, koristim je iz razloga što
  //posjeduje gotovu logiku zbrajanja vremena
  final DateTime time;
  State({required this.time});
}

abstract class EditingState extends State {
  EditingState({required super.time});
}

///Klasa stanja koja označava da je postavljanje vremena gotovo i da se program može prestat izvodit
final class EditingCompleted extends State {
  EditingCompleted({required super.time});
}

//Ispod se nalaze klase stanja koje označavaju treperenje pojedinih elemenata prikazanog vremena
// no ujedino se koristi i za označavanje pojedinog elementa vremena kojeg treba povećatis

final class BlinkHourState extends EditingState {
  BlinkHourState({required super.time});
}

final class BlinkMinuteState extends EditingState {
  BlinkMinuteState({required super.time});
}

final class BlinkSecondState extends EditingState {
  BlinkSecondState({required super.time});
}
