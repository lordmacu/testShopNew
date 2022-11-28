import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoptest/helpers/ColorsTheme.dart';
import 'package:shoptest/helpers/ui/buttonWidget.dart';
import 'package:shoptest/modules/orders/OrderController.dart';

class CreatePanelOrder extends StatelessWidget {
  OrderController _orderController = Get.put(OrderController());

  var clients = ['cliente1', 'cliente2', 'cliente3'];
  var products = ['producto1', 'producto2', 'producto3'];
  var quantity = ['1', '2', '3', '4', '5', '6', '7'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ColorsTheme.generalPadding),
      child: Column(
        children: [
          Form(
            key: _orderController.formKeyProductCreate.value,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Container(
                        child: Text("Producto:"),
                        margin: EdgeInsets.only(right: 20),
                      ),
                      Obx(() => DropdownButton(
                            // Initial Value
                            value: "${_orderController.productCreate.value}",

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: products.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String newClient) {
                              _orderController.productCreate.value = newClient;
                            },
                          ))
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(bottom: ColorsTheme.inputMarginButton),
                  child: Row(
                    children: [
                      Container(
                        child: Text("Cantidad:"),
                        margin: EdgeInsets.only(right: 20),
                      ),
                      Obx(() => DropdownButton(
                            // Initial Value
                            value:
                                "${_orderController.productQuantityCreate.value}",

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: quantity.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String newClient) {
                              _orderController.productQuantityCreate.value =
                                  newClient;
                            },
                          ))
                    ],
                  ),
                ),
                Container(
                    margin:
                        EdgeInsets.only(bottom: ColorsTheme.inputMarginButton),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty) {
                          return ' Ingresa el sku';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        _orderController.productSkuCreate.value = text;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Sku',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )),
                Container(
                    margin:
                        EdgeInsets.only(bottom: ColorsTheme.inputMarginButton),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty) {
                          return ' Ingresa el precio';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        var textEdit = text
                            .replaceAll(",", "")
                            .replaceAll(".", "")
                            .replaceAll("-", "");
                        _orderController.priceDetailCreate.value =
                            int.parse(text);
                      },
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Precio',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )),
                Container(
                    margin:
                        EdgeInsets.only(bottom: ColorsTheme.inputMarginButton),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Ingrese el detalle';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        _orderController.productDetailCreate.value = text;
                      },
                      obscureText: false,
                      minLines: 2,
                      maxLines: 4,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Detalle',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )),
                ButtonW(
                  onTab: () async {
                    _orderController.formKeyProductCreate.value.currentState
                        .validate();
                    if (_orderController.productSkuCreate.value.length > 0 &&
                        _orderController.productDetailCreate.value.length > 0) {
                      _orderController.addProductOrder();
                    }else{
                      Get.snackbar('Datos Incorrectos', 'Verifica los datos del producto');
                    }
                  },
                  label: "Agregar Producto",
                  colorText: Colors.white,
                  colorBackground: ColorsTheme.textColor,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
