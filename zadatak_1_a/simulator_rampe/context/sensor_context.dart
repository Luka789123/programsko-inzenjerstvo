import 'dart:async';
import '../event/event.dart';
import '../state/sensor_state/sensor_activated_state.dart';
import '../state/sensor_state/sensor_idle_state.dart';
import '../state/sensor_state/sensor_state.dart';
import '../state/validator_state/valid_state.dart';
import 'context.dart';
import 'validator_context.dart';

class SensorContext extends Context<SensorState> {
  late StreamController<SensorState> _sensorNotificationController;
  SensorState _currentSensorState = SensorIdleState();
  ValidatorContext _validatorContext = ValidatorContext();
  SensorContext() {
    _sensorNotificationController = StreamController<SensorState>.broadcast(
      onListen: () => changeSensorState(SensorEvent.idle),
    );
    _validatorContext.output().listen((event) {
      if (event is ValidState) {
        changeSensorState(SensorEvent.focusGained);
      }
    });
  }
  @override
  Stream<SensorState> output() => _sensorNotificationController.stream;

  void changeSensorState(SensorEvent event) {
    switch (event) {
      case SensorEvent.focusGained:
        _currentSensorState = SensorActivatedState();
        _sensorNotificationController.add(_currentSensorState);
        break;
      default:
        _currentSensorState = SensorIdleState();
        _sensorNotificationController.add(_currentSensorState);
    }
  }

  @override
  void close() {
    _sensorNotificationController.close();
  }

  @override
  SensorState getCurrentState() => _currentSensorState;
}
