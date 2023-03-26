import 'package:test/test.dart';

import 'package:dart_injektor/injektor.dart';

void main() {
  group('injektor tests =>', () {
    late Injektor injektor;

    setUp(() => injektor = Injektor());

    tearDown(() => injektor.disposeAll());

    test('should throw if no instance or factory is registered.', () {
      expect(() => injektor<SampleClass>(), throwsException);
    });

    test('should register an instance and resolve it.', () {
      final SampleClass instance = SampleClass();

      injektor.register<SampleClass>(instance);

      expect(injektor<SampleClass>(), equals(instance));
    });

    test('should throw if instance is already registered.', () {
      final SampleClass instance1 = SampleClass();
      final SampleClass instance2 = SampleClass();

      injektor.register<SampleClass>(instance1);

      expect(() => injektor.register<SampleClass>(instance2), throwsException);
    });

    test('should lazy register a factory and resolve it.', () {
      injektor.lazyRegister<SampleClass>(() => SampleClass());

      expect(injektor<SampleClass>(), isA<SampleClass>());
    });

    test('should throw if factory is already registered.', () {
      SampleClass factory1() => SampleClass();
      SampleClass factory2() => SampleClass();

      injektor.lazyRegister<SampleClass>(factory1);

      expect(
        () => injektor.lazyRegister<SampleClass>(factory2),
        throwsException,
      );
    });

    test('should resolve a lazily registered factory only once.', () {
      SampleClass factory() => SampleClass(1);

      injektor.lazyRegister<SampleClass>(factory);

      final SampleClass instance1 = injektor<SampleClass>();
      final SampleClass instance2 = injektor<SampleClass>();

      expect(instance1, equals(instance2));

      expect(instance1.count, equals(1));
      expect(instance2.count, equals(1));
    });

    test('should resolve an instance registered after lazy registration.', () {
      final SampleClass instance = SampleClass(1);
      SampleClass factory() => SampleClass();

      injektor.register<SampleClass>(instance);
      injektor.lazyRegister<SampleClass>(factory);

      expect(injektor<SampleClass>(), equals(instance));
      expect(injektor<SampleClass>().count, equals(1));
    });

    test('should dispose an instance and resolve it again.', () {
      final SampleClass instance = SampleClass();

      injektor.register<SampleClass>(instance);
      injektor.dispose<SampleClass>();

      expect(() => injektor<SampleClass>(), throwsException);
    });

    test('should dispose a factory and resolve it again.', () {
      SampleClass factory() => SampleClass();

      injektor.lazyRegister<SampleClass>(factory);
      injektor.dispose<SampleClass>();

      expect(() => injektor<SampleClass>(), throwsException);
    });

    test('should dispose all instances and factories.', () {
      final SampleClass instance = SampleClass();

      SampleClass factory() => SampleClass();

      injektor.register<SampleClass>(instance);
      injektor.lazyRegister<SampleClass>(factory);

      injektor.disposeAll();

      expect(() => injektor<SampleClass>(), throwsException);
    });
  });
}

class SampleClass {
  SampleClass([this.count = 0]);

  final int count;
}
