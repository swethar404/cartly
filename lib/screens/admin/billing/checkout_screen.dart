import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/sales/order_model.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/order_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String paymentMethod = "Cash";

  final TextEditingController discountController =
  TextEditingController();

  @override
  void dispose() {
    discountController.dispose();
    super.dispose();
  }

  Future<void> completeOrder() async {
    final cart = context.read<CartProvider>();
    final orderProvider = context.read<OrderProvider>();

    final subtotal = cart.subtotal;

    final discount =
        double.tryParse(discountController.text) ?? 0;

    final total = subtotal - discount;

    final now = DateTime.now();

    final order = OrderModel(
      orderNumber: "ORD-${now.millisecondsSinceEpoch}",
      orderDate: now.toIso8601String(),
      subtotal: subtotal,
      discount: discount,
      total: total,
      paymentMethod: paymentMethod,
    );

    await orderProvider.addOrder(order);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Order Saved Successfully"),
      ),
    );

    cart.clear();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    final subtotal = cart.subtotal;

    final discount =
        double.tryParse(discountController.text) ?? 0;

    final grandTotal = subtotal - discount;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Items"),
                        Text(cart.totalItems.toString()),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Subtotal"),
                        Text(
                          "₹ ${subtotal.toStringAsFixed(2)}",
                        ),
                      ],
                    ),
                    const Divider(),
                    TextField(
                      controller: discountController,
                      keyboardType:
                      TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Discount",
                        prefixIcon: Icon(Icons.discount),
                      ),
                      onChanged: (_) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Grand Total",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                        Text(
                          "₹ ${grandTotal.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.green,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            DropdownButtonFormField<String>(
              value: paymentMethod,
              decoration: const InputDecoration(
                labelText: "Payment Method",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: "Cash",
                  child: Text("Cash"),
                ),
                DropdownMenuItem(
                  value: "Card",
                  child: Text("Card"),
                ),
                DropdownMenuItem(
                  value: "UPI",
                  child: Text("UPI"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  paymentMethod = value!;
                });
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.receipt_long),
                label: const Text(
                  "Complete Billing",
                ),
                onPressed: completeOrder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}