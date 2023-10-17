import 'dart:async';
import '../state/ramp_state/ramp_down_action_state.dart';
import '../state/ramp_state/ramp_state.dart';
import '../state/ramp_state/ramp_up_action_state.dart';
import '../state/sensor_state/sensor_action_state.dart';
import '../state/sensor_state/sensor_card_valid_state.dart';
import 'context.dart';
import 'sensor_context.dart';

class RampContext extends Context<RampState> {
  final SensorContext sensorContext;
  late final StreamSubscription _sensorStreamSubscription;
  RampContext({required this.sensorContext}) {
    streamController = StreamController.broadcast();
    _sensorStreamSubscription = sensorContext.output().listen((event) {
      if (event is SensorCardValidState) {
        _currentState = RampUpActionState();
        streamController.add(_currentState);
      } else if (event is SensorActionState) {
        _currentState = RampDownActionState();
        streamController.add(_currentState);
      }
    });
  }
  RampState _currentState = RampDownActionState();
  late StreamController<RampState> streamController;

  @override
  Stream<RampState> output() => streamController.stream;

  @override
  RampState getCurrentState() => _currentState;

  @override
  void close() {
    streamController.close();
    _sensorStreamSubscription.cancel();
  }
}
