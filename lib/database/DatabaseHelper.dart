import 'package:path/path.dart';
import 'package:shoptest/modules/orders/model/Order.dart';
import 'package:shoptest/modules/orders/model/Product.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = 'ordersdbs.db';
  static final _versionDb = 2;
  static final table = 'orders';
  static final indexId = 'id';

  static final _orders_table = 'orders';
  static final _products_table = 'products';
  static final _order_products_table = 'order_products';

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDb();

    return _database;
  }

  _initDb() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _versionDb, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    //create table orders
    await db.execute('CREATE TABLE $_orders_table('
        'id INTEGER PRIMARY  KEY AUTOINCREMENT, client INTEGER, order_date STRING, order_number STRING'
        ')');

    await db.execute('CREATE TABLE $_products_table('
        'id INTEGER PRIMARY  KEY AUTOINCREMENT, title STRING, price STRING, detail STRING, sku STRING'
        ')');

    await db.execute('CREATE TABLE $_order_products_table('
        'id INTEGER PRIMARY  KEY AUTOINCREMENT, orderp INTEGER, product INTEGER'
        ')');
  }

  Future<int> insertOrder(Order order) async {
    Database db = await DatabaseHelper._database;
    return await db.insert(_orders_table, {
      'client': order.client,
      'order_date': order.dateOrder,
      'order_number': order.orderNumber,
    });
  }

  Future<int> insertProduct(Product product) async {
    Database db = await DatabaseHelper._database;
    return await db.insert(_products_table, {
      'title': product.title,
      'price': product.price,
      'detail': product.detail,
      'sku': product.sku,
    });
  }

  Future<int> insertProductOrder(int product, int order) async {
    Database db = await DatabaseHelper._database;
    return await db.insert(_order_products_table, {
      'orderp': order,
      'product': product,
    });
  }

  Future<List<Map<String, dynamic>>> queryProductsOrder(order) async {
    Database db = await DatabaseHelper._database;
    return await db.rawQuery(
        'SELECT * FROM ${_order_products_table}  JOIN ${_products_table} on ${_products_table}.id = ${_order_products_table}.product WHERE orderp = ${order}');
  }

  Future<List<Map<String, dynamic>>> getAllOrders() async {
    Database db = await DatabaseHelper._database;
    return await db.query(_orders_table);
  }
}
