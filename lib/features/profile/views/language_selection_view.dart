import 'package:flutter/material.dart';
import 'package:hotel_app/core/localization/app_localizations.dart';
import 'package:hotel_app/core/services/language_service.dart';

/// Language Selection View
class LanguageSelectionView extends StatefulWidget {
  const LanguageSelectionView({super.key});

  @override
  State<LanguageSelectionView> createState() => _LanguageSelectionViewState();
}

class _LanguageSelectionViewState extends State<LanguageSelectionView> {
  final LanguageService _languageService = LanguageService();
  final AppLocalizations _localizations = AppLocalizations();
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = _languageService.currentLanguage;
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
          _localizations.language,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildLanguageOption(
            'en',
            'English',
            'English',
            Icons.language,
          ),
          const SizedBox(height: 12),
          _buildLanguageOption(
            'km',
            'ភាសាខ្មែរ',
            'Khmer',
            Icons.language,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    String code,
    String nativeName,
    String englishName,
    IconData icon,
  ) {
    final isSelected = _selectedLanguage == code;
    return GestureDetector(
      onTap: () async {
        setState(() {
          _selectedLanguage = code;
        });
        // Change language
        _languageService.changeLanguage(code);
        
        // Wait a bit for the language change to propagate
        await Future.delayed(const Duration(milliseconds: 100));
        
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                code == 'en'
                    ? 'Language changed to $englishName'
                    : 'បានផ្លាស់ប្តូរភាសាទៅ $nativeName',
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
        
        // Pop back after a short delay
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pop(context);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.purple : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.purple.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.purple,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nativeName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.purple : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    englishName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.purple,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}

