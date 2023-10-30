import 'base_encoder.dart';

class CeasarDecoder extends BaseDecorator {
  CeasarDecoder({required super.encoder});

  @override
  String getMessage() {
    String messageToDecode = encoder.getMessage();
    String decodedMessage = '';
    for (String element in messageToDecode.split(';')) {
      int? tempUtfValue = int.tryParse(element);
      tempUtfValue != null ? decodedMessage += '${tempUtfValue - 20};' : null;
    }
    return decodedMessage;
  }
}
