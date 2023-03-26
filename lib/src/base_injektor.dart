abstract class BaseInjektor {
  void register<T>(T instance, [String identifier = 'DEFAULT']);

  void lazyRegister<T>(Function() factory, [String identifier = 'DEFAULT']);

  T resolve<T>([String identifier = 'DEFAULT']);

  void dispose<T>([String identifier = 'DEFAULT']);

  void disposeAll();
}
