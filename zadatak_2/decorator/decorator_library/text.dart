import 'encoder.dart';

class Text implements Encoder {
  final String text;

  Text({required this.text});
  @override
  String getMessage() => text;
}
