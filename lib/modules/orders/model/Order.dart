import 'package:shoptest/modules/orders/model/Product.dart';

class Order {
  String _orderNumber;
  String _client;
  String _dateOrder;
  List<Product> _products = [];

  String get orderNumber => _orderNumber;

  set orderNumber(String value) {
    _orderNumber = value;
  }

  String get client => _client;

  String get dateOrder => _dateOrder;

  set dateOrder(String value) {
    _dateOrder = value;
  }

  set client(String value) {
    _client = value;
  }

  List<Product> get products => _products;

  set products(List<Product> value) {
    _products = value;
  }

  @override
  String toString() {
    return 'Order{_orderNumber: $_orderNumber, _client: $_client, _dateOrder: $_dateOrder}';
  }
}
