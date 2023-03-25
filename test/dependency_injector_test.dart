import 'package:test/test.dart';

import 'package:dart_dependency_injector/dependency_injector.dart';

void main() {
  group('dependency injector tests =>', () {
    late DependencyInjector injector;

    setUp(() => injector = DependencyInjector());

    tearDown(() => injector.disposeAll());

    test('should register an instance and resolve it.', () {
      final SampleClass instance = SampleClass();

      injector.register<SampleClass>(instance);

      expect(injector.resolve<SampleClass>(), equals(instance));
    });

    test('should throw if instance is already registered.', () {
      final SampleClass instance1 = SampleClass();
      final SampleClass instance2 = SampleClass();

      injector.register<SampleClass>(instance1);

      expect(() => injector.register<SampleClass>(instance2), throwsException);
    });

    test('should lazy register a factory and resolve it.', () {
      SampleClass factory() => SampleClass();
      injector.lazyRegister<SampleClass>(factory);

      expect(injector.resolve<SampleClass>(), isA<SampleClass>());
    });

    test('should throw if factory is already registered.', () {
      SampleClass factory1() => SampleClass();
      SampleClass factory2() => SampleClass();

      injector.lazyRegister<SampleClass>(factory1);

      expect(
        () => injector.lazyRegister<SampleClass>(factory2),
        throwsException,
      );
    });

    test('should resolve a lazily registered factory only once.', () {
      int count = 0;

      SampleClass factory() => SampleClass(++count);
      injector.lazyRegister<SampleClass>(factory);

      final SampleClass instance1 = injector.resolve<SampleClass>();
      final SampleClass instance2 = injector.resolve<SampleClass>();

      expect(instance1, equals(instance2));
      expect(instance1.count, equals(1));
    });

    test('should resolve an instance registered after lazy registration.', () {
      SampleClass factory() => SampleClass();
      injector.lazyRegister<SampleClass>(factory);

      final SampleClass instance = SampleClass();
      injector.register<SampleClass>(instance);

      expect(injector.resolve<SampleClass>(), equals(instance));
    });

    test('should throw if no instance or factory is registered.', () {
      expect(() => injector.resolve<SampleClass>(), throwsException);
    });

    test('should dispose an instance and resolve it again.', () {
      final SampleClass instance = SampleClass();

      injector.register<SampleClass>(instance);
      injector.dispose<SampleClass>();

      expect(() => injector.resolve<SampleClass>(), throwsException);
    });

    test('should dispose a factory and resolve it again.', () {
      SampleClass factory() => SampleClass();

      injector.lazyRegister<SampleClass>(factory);
      injector.dispose<SampleClass>();

      expect(() => injector.resolve<SampleClass>(), throwsException);
    });

    test('should dispose all instances and factories.', () {
      final SampleClass instance = SampleClass();

      SampleClass factory() => SampleClass();

      injector.register<SampleClass>(instance);
      injector.lazyRegister<SampleClass>(factory);
      injector.disposeAll();

      expect(() => injector.resolve<SampleClass>(), throwsException);
    });
  });
}

class SampleClass {
  SampleClass([this.count = 0]);

  final int count;
}
