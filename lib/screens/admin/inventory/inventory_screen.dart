import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/inventory_provider.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';
import 'product_details_screen.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<InventoryProvider>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<InventoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventory"),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddProductScreen(),
            ),
          );

          provider.loadProducts();
        },
      ),

      body: provider.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : provider.products.isEmpty
          ? const Center(
        child: Text(
          "No Products Found",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: provider.products.length,
        itemBuilder: (context, index) {
          final product = provider.products[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),

            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepOrange.shade100,
                child: const Icon(
                  Icons.inventory_2,
                  color: Colors.deepOrange,
                ),
              ),

              title: Text(
                product.productName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),

                  Text(
                    "₹ ${product.sellingPrice}",
                  ),

                  Text(
                    "Stock : ${product.stock}",
                  ),

                  Text(
                    "Category : ${product.category}",
                  ),
                ],
              ),

              trailing: PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == "view") {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsScreen(
                          product: product,
                        ),
                      ),
                    );
                  }

                  if (value == "edit") {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditProductScreen(
                          product: product,
                        ),
                      ),
                    );

                    provider.loadProducts();
                  }

                  if (value == "delete") {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Delete Product"),
                          content: const Text(
                            "Are you sure you want to delete this product?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm == true) {
                      await provider.deleteProduct(
                        product.productId!,
                      );

                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Product Deleted Successfully",
                          ),
                        ),
                      );
                    }
                  }
                },

                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: "view",
                    child: Row(
                      children: [
                        Icon(Icons.visibility),
                        SizedBox(width: 10),
                        Text("View Details"),
                      ],
                    ),
                  ),

                  PopupMenuItem(
                    value: "edit",
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 10),
                        Text("Edit"),
                      ],
                    ),
                  ),

                  PopupMenuItem(
                    value: "delete",
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}