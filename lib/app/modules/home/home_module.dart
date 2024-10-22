import 'package:contador_flutter/app/modules/home/home_screen.dart';
import 'package:contador_flutter/app/modules/home/home_store.dart';
import 'package:contador_flutter/app/modules/home/orderCards/order_cards_module.dart';
import 'package:contador_flutter/app/modules/home/settings/settings_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(HomeStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => HomeScreen());
    r.module('/settings', module: SettingsModule());
    r.module('/orderCards', module: OrderCardsModule());
  }
}