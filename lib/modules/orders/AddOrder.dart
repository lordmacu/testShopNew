import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shoptest/helpers/ColorsTheme.dart';
import 'package:shoptest/helpers/ui/buttonWidget.dart';
import 'package:shoptest/modules/orders/OrderController.dart';
import 'package:shoptest/modules/orders/model/Product.dart';
import 'package:shoptest/modules/orders/widgets/CreateOrderPanel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddOrder extends StatelessWidget {
  final OrderController _orderController = Get.put(OrderController());

  var clients = ['cliente1', 'cliente2', 'cliente3'];
  var products = ['producto1', 'producto2', 'producto3'];
  var quantity = ['1', '2', '3', '4', '5', '6', '7'];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              child: Container(
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: ColorsTheme.generalColorText,
                ),
              ),
              onTap: () {
                _orderController.loadOrders();
                Get.back();
              },
            ),
            backgroundColor: ColorsTheme.navbarColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Crear Orden",
              style: TextStyle(color: ColorsTheme.generalColorText),
            ),
          ),
          body: SlidingUpPanel(
            backdropEnabled: true,
            controller: _orderController.panelControllerCreate.value,
            minHeight: 0,
            panel: CreatePanelOrder(),
            body: Container(
              padding: EdgeInsets.all(ColorsTheme.generalPadding),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(ColorsTheme.generalPadding),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Form(
                        key: _orderController.formKeyProduct.value,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ColorsTheme.inputMarginButton),
                              child: Obx(() => ButtonW(
                                    onTab: () async {
                                      DateTime pickerDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2023));

                                      if (pickerDate != null) {
                                        _orderController.dateOrderCreate.value =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickerDate);
                                      }
                                    },
                                    label: _orderController
                                                .dateOrderCreate.value.length ==
                                            0
                                        ? "Seleccionar Fecha"
                                        : "Fecha: ${_orderController.dateOrderCreate.value}",
                                    colorText: ColorsTheme.textColor,
                                    colorBackground: Colors.white,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ColorsTheme.inputMarginButton),
                              child: Obx(() => DropdownButton(
                                    // Initial Value
                                    value:
                                        "${_orderController.clientOrderCreate.value}",

                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),

                                    // Array list of items
                                    items: clients.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String newClient) {
                                      _orderController.clientOrderCreate.value =
                                          newClient;
                                    },
                                  )),
                            ),
                            Obx(() => _orderController.idOrderCreate.value == 0
                                ? Container(
                                    child: ButtonW(
                                      onTab: () async {

                                        if (_orderController
                                                .dateOrderCreate.value.length >
                                            0) {
                                          _orderController.createOrder();
                                        }
                                      },
                                      label: "Crear Orden",
                                      colorText: Colors.white,
                                      colorBackground: ColorsTheme.textColor,
                                    ),
                                  )
                                : Container(
                                    child: ButtonW(
                                      onTab: () async {
                                        _orderController
                                            .panelControllerCreate.value
                                            .open();
                                      },
                                      label: "Agregar Producto",
                                      colorText: Colors.white,
                                      colorBackground: ColorsTheme.textColor,
                                    ),
                                  ))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Obx(() => ListView.builder(
                            itemCount:
                                _orderController.productsCreate.value.length,
                            itemBuilder: (BuildContext context, int index) {
                              Product product =
                                  _orderController.productsCreate[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 20),
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "${product.title}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      margin: EdgeInsets.only(right: 10),
                                    ),
                                    Text("${product.price} ${product.sku}")
                                  ],
                                ),
                              );
                            })))
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () {
          _orderController.loadOrders();
          Get.back();
        });
  }
}
