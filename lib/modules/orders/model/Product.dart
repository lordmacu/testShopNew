class Product {
  String _title;
  int _price;
  String _detail;
  String _sku;

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get price => _price;

  String get detail => _detail;

  set detail(String value) {
    _detail = value;
  }

  set price(int value) {
    _price = value;
  }

  String get sku => _sku;

  set sku(String value) {
    _sku = value;
  }

  Product(this._title, this._price, this._detail, this._sku);

  @override
  String toString() {
    return 'Product{_title: $_title, _price: $_price, _detail: $_detail, _sku: $_sku}';
  }
}
