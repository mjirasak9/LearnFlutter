import 'package:mjeetrn28/models/productmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDatabase = 'trn28.db';
  final String tableName = 'productTable';
  final int version = 1;
  final String SqlString =
      'CREATE TABLE productTable (productID PRIMARY KEY, productDS TEXT)';

  SQLiteHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(SqlString), version: version);
  }

  Future<Database> connectDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<Null> insertDatabase(ProductModel productModel) async {
    Database database = await connectDatabase();
    try {
      database.insert(tableName, productModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('e Insert SQL ==> ${e.toString()} ');
    }
  }

  Future<List<ProductModel>> readDatabase() async {
    Database database = await connectDatabase();
    List<ProductModel> productModels = [];
    List<Map<String, dynamic>> maps = await database.query(tableName);
    for (var map in maps) {
      ProductModel productModel = ProductModel.fromJson(map);
      productModels.add(productModel);
      print('Map ==> ${map}');
    }
    return productModels;
  }
}
