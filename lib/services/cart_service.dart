import '../models/sales/cart_item_model.dart';
import '../models/inventory/product_model.dart';

class CartService {
  CartService._();

  static final CartService instance =
  CartService._();

  final List<CartItemModel> _cart = [];

  List<CartItemModel> get cart => _cart;

  void addProduct(ProductModel product) {
    final index = _cart.indexWhere(
          (e) => e.product.productId == product.productId,
    );

    if (index == -1) {
      _cart.add(
        CartItemModel(product: product),
      );
    } else {
      _cart[index].quantity++;
    }
  }

  void increase(int index) {
    _cart[index].quantity++;
  }

  void decrease(int index) {
    if (_cart[index].quantity > 1) {
      _cart[index].quantity--;
    }
  }

  void remove(int index) {
    _cart.removeAt(index);
  }

  void clear() {
    _cart.clear();
  }

  double get subtotal {
    double total = 0;

    for (final item in _cart) {
      total += item.total;
    }

    return total;
  }

  int get totalItems {
    int total = 0;

    for (final item in _cart) {
      total += item.quantity;
    }

    return total;
  }
}