import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> placeholderTransactions = [
      {
        "date": "2026-01-31",
        "type": "Hotel Booking Payment",
        "amount": "\$120.00",
        "status": "Success",
      },
      {
        "date": "2026-01-28",
        "type": "Refund",
        "amount": "\$50.00",
        "status": "Failed",
      },
      {
        "date": "2026-01-25",
        "type": "Hotel Booking Payment",
        "amount": "\$200.00",
        "status": "Success",
      },
    ];

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 245, 249),
      appBar: AppBar(
        title: const Text("Transaction History"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: placeholderTransactions.length,
        itemBuilder: (context, index) {
          final tx = placeholderTransactions[index];
          final isSuccess = tx["status"] == "Success";
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              leading: Icon(
                isSuccess ? Icons.check_circle : Icons.error,
                color: isSuccess ? Colors.green : Colors.red,
                size: 30,
              ),
              title: Text(
                tx["type"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(tx["date"]!),
              trailing: Text(
                tx["amount"]!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSuccess ? Colors.green : Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
