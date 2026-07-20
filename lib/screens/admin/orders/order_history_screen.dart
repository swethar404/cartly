import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/order_provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() =>
      _OrderHistoryScreenState();
}

class _OrderHistoryScreenState
    extends State<OrderHistoryScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<OrderProvider>().loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrderProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
      ),

      body: provider.loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : provider.orders.isEmpty
          ? const Center(
        child: Text(
          "No Orders Found",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: provider.orders.length,
        itemBuilder: (context, index) {

          final order =
          provider.orders[index];

          return Card(
            margin: const EdgeInsets.only(
              bottom: 15,
            ),

            child: ListTile(

              leading: CircleAvatar(
                backgroundColor:
                Colors.green.shade100,
                child: const Icon(
                  Icons.receipt_long,
                  color: Colors.green,
                ),
              ),

              title: Text(
                order.orderNumber,
              ),

              subtitle: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    order.paymentMethod,
                  ),

                  Text(
                    order.orderDate,
                  ),
                ],
              ),

              trailing: Text(
                "₹${order.total.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight:
                  FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}