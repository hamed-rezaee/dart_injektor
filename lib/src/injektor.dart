import 'base_injektor.dart';

/// This is the default implementation of [BaseInjektor] that is used by [Injektor].
///
/// This class is a singleton and can be accessed using the [Injektor] factory.
class Injektor implements BaseInjektor {
  /// Returns the singleton instance of [Injektor].
  factory Injektor() => _instance;

  Injektor._();

  final Map<Type, Map<String, dynamic>> _instances =
      <Type, Map<String, dynamic>>{};
  final Map<Type, Map<String, void Function()>> _factories =
      <Type, Map<String, void Function()>>{};

  static final Injektor _instance = Injektor._();

  @override
  void register<T>(T instance, [String identifier = 'DEFAULT']) {
    if (_isInstanceRegistered<T>(identifier)) {
      throw Exception(
        'Instance already registered for type <$T> with identifier "$identifier".',
      );
    }

    if (!_instances.containsKey(T)) {
      _instances[T] = <String, dynamic>{};
    }

    _instances[T]![identifier] = instance;
  }

  @override
  void lazyRegister<T>(Function() factory, [String identifier = 'DEFAULT']) {
    if (_isFactoryRegistered<T>(identifier)) {
      throw Exception(
        'Factory already registered for type <$T> with identifier "$identifier".',
      );
    }

    if (!_factories.containsKey(T)) {
      _factories[T] = <String, void Function()>{};
    }

    _factories[T]![identifier] = factory;
  }

  @override
  T resolve<T>([String identifier = 'DEFAULT']) {
    if (_isInstanceRegistered<T>(identifier)) {
      return _instances[T]![identifier] as T;
    }

    if (_isFactoryRegistered<T>(identifier)) {
      final T instance = _factories[T]![identifier]!() as T;

      register(instance, identifier);
      _disposeFactory<T>(identifier);

      return instance;
    }

    throw Exception(
      'No instance or factory registered for type <$T> with identifier "$identifier".',
    );
  }

  @override
  void dispose<T>([String identifier = 'DEFAULT']) {
    _disposeInstance<T>(identifier);
    _disposeFactory<T>(identifier);
  }

  @override
  void disposeAll() {
    _instances.clear();
    _factories.clear();
  }

  bool _isInstanceRegistered<T>(String identifier) =>
      _instances.containsKey(T) && _instances[T]!.containsKey(identifier);

  bool _isFactoryRegistered<T>(String identifier) =>
      _factories.containsKey(T) && _factories[T]!.containsKey(identifier);

  void _disposeInstance<T>([String identifier = 'DEFAULT']) =>
      _instances[T]?.remove(identifier);

  void _disposeFactory<T>([String identifier = 'DEFAULT']) =>
      _factories[T]?.remove(identifier);
}
