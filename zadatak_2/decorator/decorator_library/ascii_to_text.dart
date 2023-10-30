import 'base_encoder.dart';

class AsciiToText extends BaseDecorator {
  AsciiToText({required super.encoder});

  @override
  String getMessage() {
    String ascii = encoder.getMessage();
    String expresion = '';
    for (String element in ascii.split(';')) {
      int? tempAscii = int.tryParse(element);
      tempAscii != null ? expresion += String.fromCharCode(tempAscii) : null;
    }
    return expresion;
  }
}
