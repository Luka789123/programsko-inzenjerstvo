import '../state.dart';

abstract class NotificationState extends State {
  final String message;

  NotificationState({required this.message});
}
