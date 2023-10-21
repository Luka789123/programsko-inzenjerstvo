import 'dart:async';

import '../state/validator_state/invalid_state.dart';
import '../state/validator_state/valid_state.dart';
import '../state/validator_state/validating_state.dart';
import '../state/validator_state/validator_initail_state.dart';
import '../state/validator_state/validator_state.dart';
import 'context.dart';

class ValidatorContext extends Context<ValidatorState> {
  static const List<int> _VALID_CARD_NUMBERS = [
    123456789,
    987654321,
    987456321
  ];
  late final StreamController<ValidatorState> _streamController;
  ValidatorState _currentValidatorState = ValidatorInitialState();
  ValidatorContext() {
    _streamController = StreamController.broadcast(
      onListen: () => validate(null),
    );
  }

  void validate(String? input) {
    if (input != null && input.isNotEmpty) {
      int? cardNumber = int.tryParse(input);
      _currentValidatorState = ValidatingState();
      _streamController.add(_currentValidatorState);
      Future.delayed(Duration(milliseconds: 500), () {
        if ((cardNumber != null && _VALID_CARD_NUMBERS.contains(cardNumber)) ||
            cardNumber == 1) {
          _currentValidatorState = ValidState();
          _streamController.add(_currentValidatorState);
        } else {
          _currentValidatorState = InvalidState();
          _streamController.add(_currentValidatorState);
          _currentValidatorState = ValidatorInitialState();
          _streamController.add(_currentValidatorState);
        }
      });
    } else {}
  }

  @override
  void close() {
    _streamController.close();
  }

  @override
  ValidatorState getCurrentState() => _currentValidatorState;

  @override
  Stream<ValidatorState> output() => _streamController.stream;
}
