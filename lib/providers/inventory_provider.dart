import 'package:flutter/material.dart';

import '../models/inventory/product_model.dart';
import '../services/inventory_service.dart';

class InventoryProvider extends ChangeNotifier {
  final InventoryService _service = InventoryService.instance;

  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // ================= LOAD PRODUCTS =================

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    _products = await _service.getProducts();

    _isLoading = false;
    notifyListeners();
  }

  // ================= ADD PRODUCT =================

  Future<void> addProduct(ProductModel product) async {
    _isLoading = true;
    notifyListeners();

    await _service.addProduct(product);

    await loadProducts();
  }

  // ================= UPDATE PRODUCT =================

  Future<void> updateProduct(ProductModel product) async {
    _isLoading = true;
    notifyListeners();

    await _service.updateProduct(product);

    await loadProducts();
  }

  // ================= DELETE PRODUCT =================

  Future<void> deleteProduct(int id) async {
    _isLoading = true;
    notifyListeners();

    await _service.deleteProduct(id);

    await loadProducts();
  }

  // ================= SEARCH PRODUCTS =================

  Future<void> searchProducts(String keyword) async {
    _isLoading = true;
    notifyListeners();

    _products = await _service.searchProducts(keyword);

    _isLoading = false;
    notifyListeners();
  }

  // ================= REDUCE STOCK =================

  Future<void> reduceStock({
    required int productId,
    required int quantity,
  }) async {
    await _service.reduceStock(
      productId: productId,
      quantity: quantity,
    );

    await loadProducts();
  }
}