import 'validator_state.dart';

class InvalidState extends ValidatorState {
  @override
  String action() => 'Card is invalid';
}
