import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqs = [
      {
        "question": "How do I change my password?",
        "answer":
            "You can change your password from your profile settings under the 'Change Password' section.",
      },
      {
        "question": "How can I view my transaction history?",
        "answer":
            "Go to the 'Transactions' tab in your profile to see all your past transactions.",
      },
      {
        "question": "What should I do if I forgot my password?",
        "answer":
            "Use the 'Forgot Password' option on the login screen to reset your password.",
      },
      {
        "question": "How do I contact support?",
        "answer":
            "You can contact support via the 'Help & Support' section in your app or email support@example.com.",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 240, 245, 249),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return ExpansionTile(
            title: Text(
              faq["question"]!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  faq["answer"]!,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
