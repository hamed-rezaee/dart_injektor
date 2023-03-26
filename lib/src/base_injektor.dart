/// Base class for Injektor.
///
/// This class is used to register and resolve dependencies.
/// It can be used to register instances and factories and resolve them later.
abstract class BaseInjektor {
  /// Registers an instance of type [T] with an optional [identifier].
  ///
  /// If no [identifier] is provided, 'DEFAULT' is used.
  ///
  /// If an instance is already registered for the given type and identifier,
  /// an exception is thrown.
  void register<T>(T instance, [String identifier = 'DEFAULT']);

  /// Registers a factory of type [T] with an optional [identifier].
  ///
  /// If no [identifier] is provided, 'DEFAULT' is used.
  ///
  /// If a factory is already registered for the given type and identifier,
  /// an exception is thrown.
  void lazyRegister<T>(Function() factory, [String identifier = 'DEFAULT']);

  /// Resolves an instance of type [T] with an optional [identifier].
  ///
  /// If no [identifier] is provided, 'DEFAULT' is used.
  ///
  /// If no instance or factory is registered for the given type and identifier,
  /// an exception is thrown.
  T resolve<T>([String identifier = 'DEFAULT']);

  /// Disposes an instance of type [T] with an optional [identifier].
  ///
  /// If no [identifier] is provided, 'DEFAULT' is used.
  void dispose<T>([String identifier = 'DEFAULT']);

  /// Disposes all instances and factories.
  ///
  /// This method is used to clear the dependency injector.
  void disposeAll();
}
