import 'context/display_context.dart';
import 'context/ramp_context.dart';
import 'context/sensor_context.dart';
import 'event/event.dart';
import 'state/display_state/acknowledge_notification_state.dart';

class Ramp {
  late final SensorContext _sensorContext;
  late final RampContext _rampContext;
  late final DisplayContext _displayContext;
  Ramp() {
    _sensorContext = SensorContext();
    _rampContext = RampContext(sensorContext: _sensorContext);
    _displayContext = DisplayContext(sensorContext: _sensorContext);
  }

  void setState(String? cardNumber) {
    _sensorContext.changeSensorState(
        SensorEvent.validateCard, cardNumber ?? '');
  }

  void dispose() {
    _sensorContext.close();
    _rampContext.close();
    _displayContext.close();
  }

  Future<void> printOutputData() async {
    _sensorContext.output().listen((event) {
      print('State in sensor:${event.action()}');
    });
    _displayContext.output().listen((event) {
      print('State in display:${event.message}');
      if (event is AcknowledgeNotificationState) {
        Future.delayed(Duration(seconds: 2), () {
          _sensorContext.changeSensorState(SensorEvent.focusLost, '');
        });
      }
    });
    _rampContext.output().listen((event) {
      print('State on ramp:${event.action()}');
    });
  }
}
