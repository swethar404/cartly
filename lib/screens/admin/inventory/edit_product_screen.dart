import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/inventory/product_model.dart';
import '../../../providers/inventory_provider.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel product;

  const EditProductScreen({
    super.key,
    required this.product,
  });

  @override
  State<EditProductScreen> createState() =>
      _EditProductScreenState();
}

class _EditProductScreenState
    extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController skuController;
  late TextEditingController barcodeController;
  late TextEditingController purchaseController;
  late TextEditingController sellingController;
  late TextEditingController stockController;
  late TextEditingController lowStockController;

  late String category;
  late String supplier;
  late DateTime expiryDate;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(text: widget.product.productName);

    skuController =
        TextEditingController(text: widget.product.sku);

    barcodeController =
        TextEditingController(text: widget.product.barcode);

    purchaseController = TextEditingController(
      text: widget.product.purchasePrice.toString(),
    );

    sellingController = TextEditingController(
      text: widget.product.sellingPrice.toString(),
    );

    stockController = TextEditingController(
      text: widget.product.stock.toString(),
    );

    lowStockController = TextEditingController(
      text: widget.product.lowStock.toString(),
    );

    category = widget.product.category;
    supplier = widget.product.supplier;
    expiryDate = DateTime.parse(widget.product.expiryDate);
  }

  @override
  void dispose() {
    nameController.dispose();
    skuController.dispose();
    barcodeController.dispose();
    purchaseController.dispose();
    sellingController.dispose();
    stockController.dispose();
    lowStockController.dispose();
    super.dispose();
  }

  Widget buildField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  Future<void> updateProduct() async {
    if (!_formKey.currentState!.validate()) return;

    final updated = ProductModel(
      productId: widget.product.productId,
      productName: nameController.text.trim(),
      sku: skuController.text.trim(),
      barcode: barcodeController.text.trim(),
      category: category,
      supplier: supplier,
      purchasePrice: double.parse(purchaseController.text),
      sellingPrice: double.parse(sellingController.text),
      stock: int.parse(stockController.text),
      lowStock: int.parse(lowStockController.text),
      expiryDate: expiryDate.toIso8601String(),
      image: widget.product.image,
    );

    await context.read<InventoryProvider>().updateProduct(updated);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Product Updated Successfully"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<InventoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildField(
                controller: nameController,
                label: "Product Name",
              ),

              buildField(
                controller: skuController,
                label: "SKU",
              ),

              buildField(
                controller: barcodeController,
                label: "Barcode",
              ),

              buildField(
                controller: purchaseController,
                label: "Purchase Price",
                keyboard: TextInputType.number,
              ),

              buildField(
                controller: sellingController,
                label: "Selling Price",
                keyboard: TextInputType.number,
              ),

              buildField(
                controller: stockController,
                label: "Stock",
                keyboard: TextInputType.number,
              ),

              buildField(
                controller: lowStockController,
                label: "Low Stock Alert",
                keyboard: TextInputType.number,
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: provider.isLoading
                      ? null
                      : updateProduct,
                  child: provider.isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Update Product"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}