import 'dart:developer' as developer;

import 'package:dart_dependency_injector/dependency_injector.dart';

void main() {
  final DependencyInjector injector = DependencyInjector();

  final SampleClass sampleClassInstance = SampleClass();
  injector.register<SampleClass>(sampleClassInstance);

  injector.lazyRegister<SampleClass>(
    () => SampleClass(type: 'factory'),
    'SAMPLE_CLASS_FACTORY_KEY',
  );

  final SampleClass resolvedDefaultInstance = injector.resolve<SampleClass>();
  developer
      .log('resolvedDefaultInstance.type: ${resolvedDefaultInstance.type}');

  final SampleClass resolvedFactoryInstance =
      injector.resolve<SampleClass>('SAMPLE_CLASS_FACTORY_KEY');
  developer
      .log('resolvedFactoryInstance.type: ${resolvedFactoryInstance.type}');

  injector.dispose<SampleClass>();

  try {
    injector.resolve<SampleClass>();
  } on Exception catch (e) {
    developer.log('$e');
  }
}

class SampleClass {
  SampleClass({this.type = 'default'});

  final String type;
}
