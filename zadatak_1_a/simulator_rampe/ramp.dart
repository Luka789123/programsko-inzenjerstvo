import 'context/display_context.dart';
import 'context/ramp_context.dart';
import 'context/sensor_context.dart';
import 'context/validator_context.dart';
import 'event/event.dart';
import 'state/display_state/acknowledge_notification_state.dart';

class Ramp {
  late final SensorContext _sensorContext;
  late final RampContext _rampContext;
  late final DisplayContext _displayContext;
  late final ValidatorContext _validatorContext;
  Ramp() {
    _sensorContext = SensorContext();
    _validatorContext = ValidatorContext();
    _rampContext = RampContext(
        validatorContext: _validatorContext, sensorContext: _sensorContext);
    _displayContext = DisplayContext(validatorContext: _validatorContext);
  }

  void setState(String? cardNumber) {
    if (cardNumber != null) {
      _validatorContext.validate(cardNumber);
      if (cardNumber == '1') {
        _changeSensorState();
      }
    }
  }

  void _changeSensorState() {
    _sensorContext.changeSensorState(SensorEvent.focusGained);
  }

  void dispose() {
    _sensorContext.close();
    _rampContext.close();
    _validatorContext.close();
    _displayContext.close();
  }

  Future<void> printOutputData() async {
    _sensorContext.output().listen((event) {
      print('State in sensor:${event.action()}');
    });
    _validatorContext.output().listen((event) {
      print('State in validator:${event.action()}');
    });
    _displayContext.output().listen((event) {
      print('State in display:${event.message}');
      if (event is AcknowledgeNotificationState) {
        _sensorContext.changeSensorState(SensorEvent.focusGained);
        _sensorContext.changeSensorState(SensorEvent.idle);
      }
    });
    _rampContext.output().listen((event) {
      print('State on ramp:${event.action()}');
    });
  }
}
