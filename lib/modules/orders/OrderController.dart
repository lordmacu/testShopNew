import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shoptest/database/DatabaseHelper.dart';
import 'package:shoptest/modules/orders/model/Order.dart';
import 'package:shoptest/modules/orders/model/Product.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OrderController extends GetxController {
  var orders = [].obs;
  var productsCreate = [].obs;
  var order = Order().obs;
  final formKeyProduct = GlobalKey<FormState>().obs;
  final formKeyProductCreate = GlobalKey<FormState>().obs;

  var panelController = PanelController().obs;
  var panelControllerCreate = PanelController().obs;

  var dateOrderCreate = "".obs;
  var clientOrderCreate = "".obs;
  var idOrderCreate = 0.obs;
  var idProductCreate = 0.obs;

  var productCreate = "".obs;
  var productQuantityCreate = "".obs;
  var productSkuCreate = "".obs;
  var productDetailCreate = "".obs;
  var priceDetailCreate = 0.obs;

  var clients = [].obs;

  initOrders() {
    clientOrderCreate.value = "cliente1";
    productQuantityCreate.value = "1";
    productSkuCreate.value = "";
    productDetailCreate.value = "";
    productCreate.value = "producto1";
    idOrderCreate.value = 0;
    idProductCreate.value = 0;
    priceDetailCreate.value = 0;
    dateOrderCreate.value = "";
    clients.value = ['cliente1', 'cliente2', 'cliente3'];
    productsCreate.value.clear();
  }

  Future loadOrders() async {
    orders.clear();

    initOrders();

    var ordersResult = await DatabaseHelper().getAllOrders();

    ordersResult.forEach((element) async {
      Order order = Order();
      order.orderNumber = "${element["order_number"]}";
      order.client = "${element["client"]}";
      order.dateOrder = "${element["order_date"]}";

      var productsResult =
          await DatabaseHelper().queryProductsOrder(element["id"]);
      productsResult.forEach((elementProduct) {

        order.products.add(Product("${elementProduct['title']}", elementProduct["price"],
            elementProduct["detail"], elementProduct["sku"]));
      });
      orders.add(order);
    });
  }

  Future createOrder() async {
    Order order = Order();
    Random randomOrder = Random();
    order.orderNumber = "${randomOrder.nextInt(1000)}";
    order.client = "${clientOrderCreate.value}";
    order.dateOrder = "${dateOrderCreate.value}";
    var insertOrder = await DatabaseHelper().insertOrder(order);
    idOrderCreate.value = insertOrder;
  }

  resetProduct() {
    productCreate.value = "producto1";
    productQuantityCreate.value = "1";
    productSkuCreate.value = "";
    productDetailCreate.value = "";
    priceDetailCreate.value = 0;
    formKeyProductCreate.value.currentState.reset();
  }

  Future addProductOrder() async {
    for (var i = 0; i < int.parse(productQuantityCreate.value); i++) {
      Product product = Product(
          "${productCreate.value}",
          priceDetailCreate.value,
          "${productDetailCreate.value}",
          "${productSkuCreate.value}");

      var insertProduct = await DatabaseHelper().insertProduct(product);
      idProductCreate.value = insertProduct;

      await DatabaseHelper()
          .insertProductOrder(idProductCreate.value, idOrderCreate.value);
    }

    var productsResult =
        await DatabaseHelper().queryProductsOrder(idOrderCreate.value);
    productsCreate.value.clear();

    productsResult.forEach((element) {
      productsCreate.value.add(Product("${element['title']}", element["price"],
          element["detail"], element["sku"]));
    });

    productsCreate.refresh();
    resetProduct();

    //loadOrders();
    panelControllerCreate.value.close();
  }
}
