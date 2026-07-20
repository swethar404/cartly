import 'package:flutter/material.dart';

import '../models/inventory/product_model.dart';
import '../services/cart_service.dart';

class CartProvider extends ChangeNotifier {
  final CartService _service =
      CartService.instance;

  List get items => _service.cart;

  double get subtotal => _service.subtotal;

  int get totalItems => _service.totalItems;

  void add(ProductModel product) {
    _service.addProduct(product);
    notifyListeners();
  }

  void increase(int index) {
    _service.increase(index);
    notifyListeners();
  }

  void decrease(int index) {
    _service.decrease(index);
    notifyListeners();
  }

  void remove(int index) {
    _service.remove(index);
    notifyListeners();
  }

  void clear() {
    _service.clear();
    notifyListeners();
  }
}