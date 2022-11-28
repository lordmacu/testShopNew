import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoptest/helpers/ColorsTheme.dart';
import 'package:shoptest/helpers/ui/cardOrder.dart';
import 'package:shoptest/helpers/ui/panelOrder.dart';
import 'package:shoptest/modules/orders/AddOrder.dart';
import 'package:shoptest/modules/orders/OrderController.dart';
import 'package:shoptest/modules/orders/model/Order.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Orders extends StatelessWidget {
  final OrderController _orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsTheme.blueBackground,
        onPressed: () {
          _orderController.initOrders();
          Get.to(AddOrder());
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: ColorsTheme.navbarColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Mis Ordenes",
          style: TextStyle(color: ColorsTheme.generalColorText),
        ),
      ),
      body: SlidingUpPanel(
        backdropEnabled: true,
        controller: _orderController.panelController.value,
        minHeight: 0,
        panel: _orderController.order.value != null
            ? Obx(() => PanelOrder(order: _orderController.order.value))
            : Container(),
        body: Container(
          margin: EdgeInsets.only(top: 20, bottom: 100),
          padding: EdgeInsets.all(ColorsTheme.generalPadding),
          child: Obx(() => ListView.builder(
              itemCount: _orderController.orders.value.length,
              itemBuilder: (BuildContext context, int index) {
                Order order = _orderController.orders.value[index];

                return CardOrderW(
                  order: order,
                  onTab: () {
                    _orderController.order.value = order;
                    _orderController.panelController.value.open();
                  },
                );
              })),
        ),
      ),
    );
  }
}
