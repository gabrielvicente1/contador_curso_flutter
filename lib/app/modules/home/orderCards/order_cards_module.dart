import 'package:contador_flutter/app/modules/home/orderCards/order_cards_screen.dart';
import 'package:contador_flutter/app/modules/home/orderCards/order_cards_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OrderCardsModule extends Module {
  @override
  void binds(i) {
    i.add(OrderCardsStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) =>  OrderCardsScreen());
  }
}
