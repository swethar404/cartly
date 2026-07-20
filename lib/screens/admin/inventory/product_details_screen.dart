import 'package:flutter/material.dart';

import '../../../models/inventory/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  Widget detailTile(String title, String value) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepOrange.shade100,
              child: const Icon(
                Icons.inventory_2,
                size: 50,
                color: Colors.deepOrange,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              product.productName,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            detailTile("SKU", product.sku),
            detailTile("Barcode", product.barcode),
            detailTile("Category", product.category),
            detailTile("Supplier", product.supplier),
            detailTile(
              "Purchase Price",
              "₹ ${product.purchasePrice}",
            ),
            detailTile(
              "Selling Price",
              "₹ ${product.sellingPrice}",
            ),
            detailTile(
              "Stock",
              product.stock.toString(),
            ),
            detailTile(
              "Low Stock Alert",
              product.lowStock.toString(),
            ),
            detailTile(
              "Expiry Date",
              product.expiryDate,
            ),
          ],
        ),
      ),
    );
  }
}