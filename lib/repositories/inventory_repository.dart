import '../database/database_service.dart';
import '../database/database_tables.dart';
import '../models/inventory/product_model.dart';

class InventoryRepository {
  InventoryRepository._();

  static final InventoryRepository instance =
  InventoryRepository._();

  final DatabaseService _database =
      DatabaseService.instance;

  // ================= ADD PRODUCT =================

  Future<int> addProduct(ProductModel product) async {
    return await _database.insert(
      DatabaseTables.products,
      product.toMap(),
    );
  }

  // ================= GET ALL PRODUCTS =================

  Future<List<ProductModel>> getProducts() async {
    final result = await _database.query(
      DatabaseTables.products,
    );

    return result
        .map((e) => ProductModel.fromMap(e))
        .toList();
  }

  // ================= GET PRODUCT =================

  Future<ProductModel?> getProduct(int id) async {
    final result = await _database.getById(
      DatabaseTables.products,
      DatabaseTables.productId,
      id,
    );

    if (result == null) return null;

    return ProductModel.fromMap(result);
  }

  // ================= UPDATE PRODUCT =================

  Future<int> updateProduct(ProductModel product) async {
    return await _database.update(
      DatabaseTables.products,
      product.toMap(),
      "${DatabaseTables.productId} = ?",
      [product.productId],
    );
  }

  // ================= DELETE PRODUCT =================

  Future<int> deleteProduct(int id) async {
    return await _database.delete(
      DatabaseTables.products,
      "${DatabaseTables.productId} = ?",
      [id],
    );
  }

  // ================= SEARCH PRODUCTS =================

  Future<List<ProductModel>> searchProducts(
      String keyword) async {
    final result = await _database.query(
      DatabaseTables.products,
      where: "${DatabaseTables.productName} LIKE ?",
      whereArgs: ["%$keyword%"],
    );

    return result
        .map((e) => ProductModel.fromMap(e))
        .toList();
  }

  // ================= REDUCE STOCK =================

  Future<void> reduceStock({
    required int productId,
    required int quantity,
  }) async {
    final result = await _database.query(
      DatabaseTables.products,
      where: "${DatabaseTables.productId} = ?",
      whereArgs: [productId],
    );

    if (result.isEmpty) return;

    final currentStock =
    (result.first[DatabaseTables.stock] as int);

    final newStock = currentStock - quantity;

    await _database.update(
      DatabaseTables.products,
      {
        DatabaseTables.stock:
        newStock < 0 ? 0 : newStock,
      },
      "${DatabaseTables.productId} = ?",
      [productId],
    );
  }
}