# Dependency Injector

This is a lightweight dependency injection library that provides the ability to register and resolve dependencies.

## Usage

To use this library, you need to import the `DependencyInjector` class from `import 'package:dart_dependency_injector/dependency_injector.dart';`.

```dart
import 'base_dependency_injector.dart';

// Fetch the dependency injector instance, or create a new one.
final injector = DependencyInjector();

// Register a dependency instance.
final myDependency = MyDependency();
injector.register<MyDependency>(myDependency);

// Resolve the dependency.
final myClass = MyClass(injector.resolve<MyDependency>());
```

## API

The `DependencyInjector` class provides the following methods:

`register<T>(T instance, [String identifier = 'DEFAULT'])`

Registers an instance of a dependency. The T type parameter specifies the type of the dependency. The `instance` parameter is the instance to be registered. The `identifier` parameter is an optional identifier for the instance. If not provided, it defaults to `DEFAULT`.

`lazyRegister<T>(Function() factory, [String identifier = 'DEFAULT'])`

Registers a factory function for a dependency. The T type parameter specifies the type of the dependency. The `factory` parameter is a function that returns an instance of the dependency. The `identifier` parameter is an optional identifier for the factory. If not provided, it defaults to `DEFAULT`.

`resolve<T>([String identifier = 'DEFAULT'])`

Resolves a dependency instance. The `T` type parameter specifies the type of the dependency. The `identifier` parameter is an optional identifier for the instance or factory to resolve. If not provided, it defaults to `DEFAULT`. If an instance is registered for the given type and identifier, it is returned. Otherwise, if a factory is registered for the given type and identifier, the factory is called to create an instance and register it before returning it. If neither an instance nor a factory is registered, an exception is thrown.

`dispose<T>([String identifier = 'DEFAULT'])`

Disposes a dependency instance or factory. The T type parameter specifies the type of the dependency. The `identifier` parameter is an optional identifier for the instance or factory to dispose. If not provided, it defaults to `DEFAULT`. If an instance is registered for the given type and identifier, it is removed from the instances map. If a factory is registered for the given type and identifier, it is removed from the factories map.

`disposeAll()`

Disposes all dependency instances and factories. Removes all instances from the instances map and all factories from the factories map.

## License

This library is licensed under the MIT License.
