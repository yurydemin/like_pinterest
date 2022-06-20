import 'package:flutter_simple_dependency_injection/Injector.dart';

abstract class BaseModule {
  final Injector injector = Injector();
  void configure(Injector injector);

  T get<T>({String? key, Map<String, dynamic>? additionalParameters}) {
    return injector.get(key: key, additionalParameters: additionalParameters);
  }
}
