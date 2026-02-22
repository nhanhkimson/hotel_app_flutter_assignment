import 'package:flutter/material.dart';
import 'package:hotel_app/core/localization/app_localizations.dart';
import 'package:hotel_app/core/services/language_service.dart';

/// Transaction History View
class TransactionHistoryView extends StatefulWidget {
  const TransactionHistoryView({super.key});

  @override
  State<TransactionHistoryView> createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends State<TransactionHistoryView> {
  final LanguageService _languageService = LanguageService();
  final AppLocalizations _localizations = AppLocalizations();

  @override
  void initState() {
    super.initState();
    _languageService.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    _languageService.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _localizations.transactionHistory,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  '12 Jan 2026',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildDateSection(_localizations.today, [
                  _buildTransaction('Villa Hotel', 'Kampot Province, Cambodia',
                      '****457', '\$150.00'),
                  _buildTransaction('Villa Hotel', 'Kampot Province, Cambodia',
                      '****457', '\$150.00'),
                  _buildTransaction('Villa Hotel', 'Kampot Province, Cambodia',
                      '****457', '\$150.00'),
                ]),
                const SizedBox(height: 24),
                _buildDateSection('Sunday, 11, January, 2026', [
                  _buildTransaction('Villa Hotel', 'Kampot Province, Cambodia',
                      '****457', '\$150.00'),
                  _buildTransaction('Villa Hotel', 'Kampot Province, Cambodia',
                      '****457', '\$150.00'),
                  _buildTransaction('Villa Hotel', 'Kampot Province, Cambodia',
                      '****457', '\$150.00'),
                  _buildTransaction('Villa Hotel', 'Kampot Province, Cambodia',
                      '****457', '\$150.00'),
                  _buildTransaction('Villa Hotel', 'Kampot Province, Cambodia',
                      '****457', '\$150.00'),
                  _buildTransaction('Villa Hotel', 'Kampot Province, Cambodia',
                      '****457', '\$150.00'),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection(String date, List<Widget> transactions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...transactions,
      ],
    );
  }

  Widget _buildTransaction(
      String hotelName, String location, String account, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.description, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotelName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  account,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }
}

