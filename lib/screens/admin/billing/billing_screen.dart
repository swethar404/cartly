import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'checkout_screen.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/inventory_provider.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<InventoryProvider>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final inventory = context.watch<InventoryProvider>();
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Billing"),
      ),

      body: Column(
        children: [

          Expanded(
            flex: 3,
            child: inventory.isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: inventory.products.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final product =
                inventory.products[index];

                return Card(
                  elevation: 3,
                  child: InkWell(
                    borderRadius:
                    BorderRadius.circular(12),
                    onTap: () {
                      cart.add(product);

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          duration: const Duration(
                            milliseconds: 700,
                          ),
                          content: Text(
                            "${product.productName} added",
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding:
                      const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [

                          const Icon(
                            Icons.inventory,
                            size: 45,
                            color: Colors.deepOrange,
                          ),

                          const SizedBox(height: 12),

                          Text(
                            product.productName,
                            textAlign:
                            TextAlign.center,
                            style: const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "₹${product.sellingPrice}",
                            style: const TextStyle(
                              color:
                              Colors.deepOrange,
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            "Stock ${product.stock}",
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [

                const SizedBox(height: 10),

                const Text(
                  "Cart",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {

                      final item = cart.items[index];

                      return ListTile(
                        title: Text(
                          item.product.productName,
                        ),

                        subtitle: Text(
                          "₹${item.product.sellingPrice}",
                        ),

                        leading: IconButton(
                          icon: const Icon(
                            Icons.remove_circle,
                          ),
                          onPressed: () {
                            cart.decrease(index);
                          },
                        ),

                        trailing: SizedBox(
                          width: 120,
                          child: Row(
                            children: [

                              Text(
                                item.quantity.toString(),
                              ),

                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle,
                                ),
                                onPressed: () {
                                  cart.increase(index);
                                },
                              ),

                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  cart.remove(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        "Items : ${cart.totalItems}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "₹ ${cart.subtotal.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding:
                  const EdgeInsets.all(15),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: cart.items.isEmpty
                          ? null
                          : () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CheckoutScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Proceed To Checkout",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}