import 'decorator_library/zadatak_2.dart';

void main() {
  Text text = Text(text: 'Hello World!');
  TextToAscii textToAscii = TextToAscii(encoder: text);
  print('utf values: ${textToAscii.getMessage()}');
  CeasarEncoder encoder = CeasarEncoder(encoder: textToAscii);
  print('encoded values ${encoder.getMessage()}');
  CeasarDecoder ceasarDecoder = CeasarDecoder(encoder: encoder);
  print('utf values: ${ceasarDecoder.getMessage()}');
  AsciiToText asciiToText = AsciiToText(encoder: ceasarDecoder);
  print('decoded values ${asciiToText.getMessage()}');
}
