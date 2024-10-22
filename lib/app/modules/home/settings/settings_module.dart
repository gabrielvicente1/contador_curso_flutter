import 'package:contador_flutter/app/modules/home/settings/settings_screen.dart';
import 'package:contador_flutter/app/modules/home/settings/settings_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SettingsModule extends Module {
  @override
  void binds(i) {
    i.add(SettingsStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) =>  SettingsScreen());
  }
}
