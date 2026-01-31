import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 245, 249),
      appBar: AppBar(
        title: const Text("About App"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 240, 245, 249),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.lightBlue[100],
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.hotel, size: 60, color: Colors.lightBlue),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Hotel Booking App",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Version 1.0.0",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              "Welcome to Hotel Booking App! "
              "Our app helps you find and book hotels easily and securely. "
              "You can browse hotels, view rooms, check availability, "
              "and make payments directly from your phone.",
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              "Contact Us",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Email: support@hotelapp.com\nPhone: +855 234 567 890",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              "© 2026 Hotel Booking. All rights reserved.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
