import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:like_pinterest/src/blocs/images/images_bloc.dart';
import 'package:like_pinterest/src/di/base_module.dart';
import 'package:like_pinterest/src/repositories/images/images_repository.dart';
import 'package:like_pinterest/src/repositories/images/webapi_images_repository.dart';

class MainModule extends BaseModule {
  static final MainModule _mainModule = MainModule._internal();

  factory MainModule() {
    return _mainModule;
  }

  MainModule._internal() {
    configure(injector);
  }

  @override
  void configure(Injector injector) {
    injector.map<ImagesRepository>((i) => WebApiImagesRepository(),
        isSingleton: true);
    injector.map<String>((i) => "https://picsum.photos/v2/list");
    injector.map<ImagesBloc>(
        (i) => ImagesBloc(i.get<ImagesRepository>(), i.get<String>()));
  }
}
