import 'dart:async';
import '../state/ramp_state/ramp_down_action_state.dart';
import '../state/ramp_state/ramp_state.dart';
import '../state/ramp_state/ramp_up_action_state.dart';
import '../state/sensor_state/sensor_activated_state.dart';
import '../state/sensor_state/sensor_idle_state.dart';
import '../state/validator_state/valid_state.dart';
import 'context.dart';
import 'sensor_context.dart';
import 'validator_context.dart';

class RampContext extends Context<RampState> {
  final ValidatorContext validatorContext;
  final SensorContext sensorContext;
  late final StreamSubscription _validatorStreamSubscription;
  RampContext({required this.validatorContext, required this.sensorContext}) {
    streamController = StreamController.broadcast();
    _validatorStreamSubscription = validatorContext.output().listen((event) {
      if (event is ValidState) {
        _currentState = RampUpActionState();
        streamController.add(_currentState);
      }
    });
    sensorContext.output().listen((event) {
      if (event is SensorActivatedState &&
          _currentState is! RampUpActionState) {
        _currentState = RampUpActionState();
        streamController.add(_currentState);
      } else if (event is SensorIdleState &&
          _currentState is! RampDownActionState) {
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
    _validatorStreamSubscription.cancel();
  }
}
