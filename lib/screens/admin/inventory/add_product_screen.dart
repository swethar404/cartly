import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/inventory/product_model.dart';
import '../../../providers/inventory_provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final skuController = TextEditingController();
  final barcodeController = TextEditingController();
  final purchaseController = TextEditingController();
  final sellingController = TextEditingController();
  final stockController = TextEditingController();
  final lowStockController = TextEditingController();

  String category = "Groceries";
  String supplier = "Default Supplier";

  DateTime expiryDate = DateTime.now();

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

  Future<void> saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    final product = ProductModel(
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
      image: "",
    );

    await context.read<InventoryProvider>().addProduct(product);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Product Added Successfully"),
      ),
    );

    Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<InventoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
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

              DropdownButtonFormField<String>(
                value: category,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Category",
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Groceries",
                    child: Text("Groceries"),
                  ),
                  DropdownMenuItem(
                    value: "Snacks",
                    child: Text("Snacks"),
                  ),
                  DropdownMenuItem(
                    value: "Beverages",
                    child: Text("Beverages"),
                  ),
                  DropdownMenuItem(
                    value: "Electronics",
                    child: Text("Electronics"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    category = value!;
                  });
                },
              ),

              const SizedBox(height: 18),

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
                label: "Stock Quantity",
                keyboard: TextInputType.number,
              ),

              buildField(
                controller: lowStockController,
                label: "Low Stock Alert",
                keyboard: TextInputType.number,
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                  provider.isLoading ? null : saveProduct,
                  child: provider.isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Save Product"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}