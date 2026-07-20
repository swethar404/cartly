import '../models/inventory/product_model.dart';
import '../repositories/inventory_repository.dart';

class InventoryService {
  InventoryService._();

  static final InventoryService instance = InventoryService._();

  final InventoryRepository _repository =
      InventoryRepository.instance;

  // ================= ADD PRODUCT =================

  Future<int> addProduct(ProductModel product) async {
    return await _repository.addProduct(product);
  }

  // ================= GET ALL PRODUCTS =================

  Future<List<ProductModel>> getProducts() async {
    return await _repository.getProducts();
  }

  // ================= GET PRODUCT =================

  Future<ProductModel?> getProduct(int id) async {
    return await _repository.getProduct(id);
  }

  // ================= UPDATE PRODUCT =================

  Future<int> updateProduct(ProductModel product) async {
    return await _repository.updateProduct(product);
  }

  // ================= DELETE PRODUCT =================

  Future<int> deleteProduct(int id) async {
    return await _repository.deleteProduct(id);
  }

  // ================= SEARCH PRODUCTS =================

  Future<List<ProductModel>> searchProducts(
      String keyword,
      ) async {
    return await _repository.searchProducts(keyword);
  }

  // ================= REDUCE STOCK =================

  Future<void> reduceStock({
    required int productId,
    required int quantity,
  }) async {
    await _repository.reduceStock(
      productId: productId,
      quantity: quantity,
    );
  }
}