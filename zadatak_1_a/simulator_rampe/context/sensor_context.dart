import 'dart:async';

import '../event/event.dart';
import '../state/sensor_state/sensor_action_state.dart';
import '../state/sensor_state/sensor_card_invalid_state.dart';
import '../state/sensor_state/sensor_card_valid_state.dart';
import '../state/sensor_state/sensor_card_validating_state.dart';
import '../state/sensor_state/sensor_idle_state.dart';
import '../state/sensor_state/sensor_state.dart';
import 'context.dart';

class SensorContext extends Context<SensorState> {
  static const List<int> _VALID_CARD_NUMBERS = [
    123456789,
    987654321,
    987456321
  ];
  late StreamController<SensorState> _sensorNotificationController;
  SensorState _currentSensorState = SensorIdleState();

  SensorContext() {
    _sensorNotificationController = StreamController<SensorState>.broadcast(
      onListen: () => changeSensorState(SensorEvent.idle, ''),
    );
  }
  @override
  Stream<SensorState> output() => _sensorNotificationController.stream;

  void changeSensorState(SensorEvent event, String input) {
    switch (event) {
      case SensorEvent.validateCard:
        _validate(input);
        break;
      case SensorEvent.focusLost:
        _currentSensorState = SensorActionState();
        _sensorNotificationController.add(_currentSensorState);
        break;
      default:
        _currentSensorState = SensorIdleState();
        _sensorNotificationController.add(_currentSensorState);
    }
  }

  void _validate(String? input) {
    if (input != null && input.isNotEmpty) {
      int? cardNumber = int.tryParse(input);
      _currentSensorState = SensorCardValidatingState();
      _sensorNotificationController.add(_currentSensorState);
      Future.delayed(Duration(milliseconds: 500), () {
        if (cardNumber != null && _VALID_CARD_NUMBERS.contains(cardNumber)) {
          _currentSensorState = SensorCardValidState();

          _sensorNotificationController.add(SensorCardValidState());
        } else {
          _currentSensorState = SensorCardinvalidState();
          _sensorNotificationController.add(SensorCardinvalidState());
          _currentSensorState = SensorIdleState();
          _sensorNotificationController.add(_currentSensorState);
        }
      });
    } else {
      _sensorNotificationController.add(SensorCardinvalidState());
    }
  }

  @override
  void close() {
    _sensorNotificationController.close();
  }

  @override
  SensorState getCurrentState() => _currentSensorState;
}
