import 'dart:developer' as developer;

import 'package:dart_injektor/injektor.dart';

void main() {
  final Injektor injektor = Injektor();

  final SampleClass sampleClassInstance = SampleClass();
  injektor.register<SampleClass>(sampleClassInstance);

  injektor.lazyRegister<SampleClass>(
    () => SampleClass(type: 'factory'),
    'SAMPLE_CLASS_FACTORY_KEY',
  );

  final SampleClass resolvedDefaultInstance = injektor<SampleClass>();
  developer
      .log('resolvedDefaultInstance.type: ${resolvedDefaultInstance.type}');

  final SampleClass resolvedFactoryInstance =
      injektor<SampleClass>('SAMPLE_CLASS_FACTORY_KEY');
  developer
      .log('resolvedFactoryInstance.type: ${resolvedFactoryInstance.type}');

  injektor.dispose<SampleClass>();

  try {
    injektor<SampleClass>();
  } on Exception catch (e) {
    developer.log('$e');
  }
}

class SampleClass {
  SampleClass({this.type = 'default'});

  final String type;
}
