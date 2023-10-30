import 'base_encoder.dart';

class TextToAscii extends BaseDecorator {
  TextToAscii({required super.encoder});

  @override
  String getMessage() {
    String messageToConvert = encoder.getMessage();
    String encodedValue = '';
    for (int element in messageToConvert.codeUnits) {
      encodedValue += '${element};';
    }
    return encodedValue;
  }
}
