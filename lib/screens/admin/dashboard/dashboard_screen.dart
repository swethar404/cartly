import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget statCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(height: 20),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quickAction(IconData icon, String title) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.deepOrange.shade100,
            child: Icon(
              icon,
              color: Colors.deepOrange,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Dashboard"),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.notifications_none),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Welcome Back 👋",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Store Owner",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            Row(
              children: [

                statCard(
                  title: "Revenue",
                  value: "₹48K",
                  icon: Icons.currency_rupee,
                  color: Colors.green,
                ),

                statCard(
                  title: "Orders",
                  value: "126",
                  icon: Icons.shopping_cart,
                  color: Colors.orange,
                ),
              ],
            ),

            Row(
              children: [

                statCard(
                  title: "Products",
                  value: "420",
                  icon: Icons.inventory,
                  color: Colors.blue,
                ),

                statCard(
                  title: "Customers",
                  value: "58",
                  icon: Icons.people,
                  color: Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [

                  quickAction(Icons.add_box, "Add Product"),

                  quickAction(Icons.inventory, "Inventory"),

                  quickAction(Icons.receipt_long, "Orders"),

                  quickAction(Icons.analytics, "Reports"),

                  quickAction(Icons.people, "Customers"),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.warning,
                    color: Colors.white,
                  ),
                ),
                title: const Text("Low Stock Alert"),
                subtitle: const Text(
                  "Rice, Milk and Soap need restocking.",
                ),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text("View"),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.lightbulb,
                    color: Colors.white,
                  ),
                ),
                title: const Text("AI Insight"),
                subtitle: const Text(
                  "Soft Drinks sales increased by 18% this week.",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}