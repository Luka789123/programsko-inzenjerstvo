import 'base_encoder.dart';

class CeasarEncoder extends BaseDecorator {
  CeasarEncoder({required super.encoder});

  @override
  String getMessage() {
    String messageToEncode = encoder.getMessage();
    String encodedMessage = '';
    for (String element in messageToEncode.split(';')) {
      int? tempUTFValue = int.tryParse(element);
      tempUTFValue != null ? tempUTFValue += 20 : null;
      encodedMessage += '${tempUTFValue};';
    }
    return encodedMessage;
  }
}
