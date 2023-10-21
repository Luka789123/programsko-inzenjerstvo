import 'dart:async';
import '../state/display_state/acknowledge_notification_state.dart';
import '../state/display_state/display_state.dart';
import '../state/display_state/error_notification_state.dart';
import '../state/display_state/validating_notification_state.dart';
import '../state/display_state/welcome_notification_state.dart';
import '../state/validator_state/invalid_state.dart';
import '../state/validator_state/valid_state.dart';
import 'context.dart';
import 'validator_context.dart';

class DisplayContext extends Context<DisplayState> {
  late StreamController<DisplayState> _displayStateController;
  DisplayState _currentDisplayState = WelcomeNotificationState();

  final ValidatorContext validatorContext;
  late final StreamSubscription _validatorStreamSubscription;
  DisplayContext({required this.validatorContext}) {
    _displayStateController = StreamController();
    _validatorStreamSubscription = validatorContext.output().listen((event) {
      if (event is ValidatingNotificationState) {
        _currentDisplayState = ValidatingNotificationState();
        _displayStateController.add(_currentDisplayState);
      } else if (event is ValidState) {
        _currentDisplayState = AcknowledgeNotificationState();
        _displayStateController.add(_currentDisplayState);
      } else if (event is InvalidState) {
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
    _validatorStreamSubscription.cancel();
  }

  @override
  DisplayState getCurrentState() => _currentDisplayState;

  @override
  Stream<DisplayState> output() => _displayStateController.stream;
}
