import 'dart:async';

import '../state/display_state/acknowledge_notification_state.dart';
import '../state/display_state/display_state.dart';
import '../state/display_state/error_notification_state.dart';
import '../state/display_state/validating_notification_state.dart';
import '../state/display_state/welcome_notification_state.dart';
import '../state/sensor_state/sensor_card_invalid_state.dart';
import '../state/sensor_state/sensor_card_valid_state.dart';
import '../state/sensor_state/sensor_card_validating_state.dart';
import 'context.dart';
import 'sensor_context.dart';

class DisplayContext extends Context<DisplayState> {
  late StreamController<DisplayState> _displayStateController;
  DisplayState _currentDisplayState = WelcomeNotificationState();

  final SensorContext sensorContext;
  late final StreamSubscription _sensorStreamSubscription;
  DisplayContext({required this.sensorContext}) {
    _displayStateController = StreamController();
    _sensorStreamSubscription = sensorContext.output().listen((event) {
      if (event is SensorCardValidatingState) {
        _currentDisplayState = ValidatingNotificationState();
        _displayStateController.add(_currentDisplayState);
      } else if (event is SensorCardValidState) {
        _currentDisplayState = AcknowledgeNotificationState();
        _displayStateController.add(_currentDisplayState);
      } else if (event is SensorCardinvalidState) {
        _currentDisplayState = ErrorNotificationState();
        _displayStateController.add(_currentDisplayState);
      } else {
        _currentDisplayState = WelcomeNotificationState();
        _displayStateController.add(_currentDisplayState);
      }
    });
  }

  @override
  void close() {
    _displayStateController.close();
    _sensorStreamSubscription.cancel();
  }

  @override
  DisplayState getCurrentState() => _currentDisplayState;

  @override
  Stream<DisplayState> output() => _displayStateController.stream;
}
