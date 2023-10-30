import 'encoder.dart';

abstract class BaseDecorator implements Encoder {
  final Encoder encoder;

  BaseDecorator({required this.encoder});
}
