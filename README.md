# Injektor

This is a lightweight dependency injection package in Dart language that provides the ability to register and resolve dependencies.

## Usage

```dart
import 'package:dart_injektor/injektor.dart';

// Fetch the dependency injector instance, or create a new one.
final injektor = Injektor();

// Register a dependency instance.
final myDependency = MyDependency();
injektor.register<MyDependency>(myDependency);

// Resolve the dependency.
// Alternatively, you can use the `resolve` or `call` methods to be more explicit.
final myClass = MyClass(injektor<MyDependency>());
```

## API

The `Injektor` package provides the following methods:

> `register<T>(T instance, [String identifier = 'DEFAULT'])`

Registers an instance of a dependency. The T type parameter specifies the type of the dependency. The `instance` parameter is the instance to be registered. The `identifier` parameter is an optional identifier for the instance. If not provided, it defaults to `DEFAULT`.

> `lazyRegister<T>(Function() factory, [String identifier = 'DEFAULT'])`

Registers a factory function for a dependency. The T type parameter specifies the type of the dependency. The `factory` parameter is a function that returns an instance of the dependency. The `identifier` parameter is an optional identifier for the factory. If not provided, it defaults to `DEFAULT`.

> `resolve<T>([String identifier = 'DEFAULT'])`

> `call<T>([String identifier = 'DEFAULT'])`

> `<T>([String identifier = 'DEFAULT'])`

Resolves a dependency instance. The `T` type parameter specifies the type of the dependency. The `identifier` parameter is an optional identifier for the instance or factory to resolve. If not provided, it defaults to `DEFAULT`. If an instance is registered for the given type and identifier, it is returned. Otherwise, if a factory is registered for the given type and identifier, the factory is called to create an instance and register it before returning it. If neither an instance nor a factory is registered, an exception is thrown.

> `dispose<T>([String identifier = 'DEFAULT'])`

Disposes a dependency instance or factory. The T type parameter specifies the type of the dependency. The `identifier` parameter is an optional identifier for the instance or factory to dispose. If not provided, it defaults to `DEFAULT`. If an instance is registered for the given type and identifier, it is removed from the instances map. If a factory is registered for the given type and identifier, it is removed from the factories map.

> `disposeAll()`

Disposes all dependency instances and factories. Removes all instances from the instances map and all factories from the factories map.

## Features

- ✅ Register instance (Eager), instance is created when register.
- ✅ Register factory (Lazy), instance is created when first resolve.
- ✅ Resolve instance, return instance if exists.
- ✅ Dispose instance or factory, remove instance or factory from injector.
- ✅ Dispose All, remove all instances and factories from injector.

## License

This library is licensed under the `MIT License`.
