import 'sensor_state.dart';

class SensorIdleState extends SensorState {
  @override
  String action() => 'Sensor isn\'t active';
}
