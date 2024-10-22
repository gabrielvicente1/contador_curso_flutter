import 'package:contador_flutter/app/modules/home/home_module.dart';
import 'package:contador_flutter/app/modules/home/home_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(HomeStore.new);
  }

  @override
  void routes(r) {
    r.module('/', module: HomeModule());
  }
}
