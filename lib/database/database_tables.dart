class DatabaseTables {
  DatabaseTables._();

  // ================= DATABASE =================

  static const String databaseName = "cartly.db";
  static const int databaseVersion = 1;

  // ================= USERS =================

  static const String users = "users";

  static const String userId = "user_id";
  static const String employeeId = "employee_id";
  static const String name = "name";
  static const String email = "email";
  static const String phone = "phone";
  static const String password = "password";
  static const String role = "role";
  static const String createdAt = "created_at";

  // ================= CATEGORIES =================

  static const String categories = "categories";

  static const String categoryId = "category_id";
  static const String categoryName = "category_name";

  // ================= SUPPLIERS =================

  static const String suppliers = "suppliers";

  static const String supplierId = "supplier_id";
  static const String supplierName = "supplier_name";
  static const String supplierPhone = "supplier_phone";
  static const String supplierEmail = "supplier_email";

  // ================= PRODUCTS =================

  static const String products = "products";

  static const String productId = "product_id";
  static const String productName = "product_name";
  static const String sku = "sku";
  static const String barcode = "barcode";
  static const String category = "category";
  static const String supplier = "supplier";
  static const String purchasePrice = "purchase_price";
  static const String sellingPrice = "selling_price";
  static const String stock = "stock";
  static const String lowStock = "low_stock";
  static const String expiryDate = "expiry_date";
  static const String image = "image";

  // ================= ORDERS =================

  static const String orders = "orders";

  static const String orderId = "order_id";
  static const String customerId = "customer_id";
  static const String totalAmount = "total_amount";
  static const String status = "status";
  static const String orderDate = "order_date";

  // ================= ORDER ITEMS =================

  static const String orderItems = "order_items";

  static const String orderItemId = "order_item_id";
  static const String quantity = "quantity";
  static const String price = "price";

  // ================= NOTIFICATIONS =================

  static const String notifications = "notifications";

  static const String notificationId = "notification_id";
  static const String title = "title";
  static const String message = "message";
  static const String isRead = "is_read";

  static const String orders = "orders";
  static const String orderItems = "order_items";
  // Orders
  static const String orderId = "order_id";
  static const String orderNumber = "order_number";
  static const String orderDate = "order_date";
  static const String subtotal = "subtotal";
  static const String discount = "discount";
  static const String total = "total";
  static const String paymentMethod = "payment_method";

// Order Items
  static const String itemId = "item_id";
  static const String quantity = "quantity";
  static const String price = "price";
}