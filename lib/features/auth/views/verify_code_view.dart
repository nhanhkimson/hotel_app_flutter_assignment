import 'package:flutter/material.dart';
import 'package:hotel_app/core/localization/app_localizations.dart';
import 'package:hotel_app/core/services/language_service.dart';
import 'package:hotel_app/features/auth/views/forgot_password_new_view.dart';
import 'package:hotel_app/features/auth/widgets/auth_header.dart';

/// Verify Code View
class VerifyCodeView extends StatefulWidget {
  final String email;

  const VerifyCodeView({super.key, required this.email});

  @override
  State<VerifyCodeView> createState() => _VerifyCodeViewState();
}

class _VerifyCodeViewState extends State<VerifyCodeView> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final LanguageService _languageService = LanguageService();
  final AppLocalizations _localizations = AppLocalizations();

  String _maskEmail(String email) {
    if (email.length <= 2) return email;
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final username = parts[0];
    if (username.length <= 2) return email;
    final masked = '${username.substring(0, 2)}${'*' * (username.length - 2)}';
    return '$masked@${parts[1]}';
  }

  @override
  void initState() {
    super.initState();
    _languageService.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    _languageService.removeListener(_onLanguageChanged);
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onLanguageChanged() {
    setState(() {});
  }

  void _onCodeChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    // Auto-verify when all 6 digits are entered
    if (_getEnteredCode().length == 6) {
      _verifyCode();
    }
  }

  String _getEnteredCode() {
    return _controllers.map((controller) => controller.text).join();
  }

  void _verifyCode() {
    final enteredCode = _getEnteredCode();
    if (enteredCode.length == 6) {
      if (enteredCode == '123456') {
        // Valid code - navigate to new password screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ForgotPasswordNewView(),
          ),
        );
      } else {
        // Invalid code - show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _localizations.isEnglish
                  ? 'Invalid verification code. Please try again.'
                  : 'លេខកូដផ្ទៀងផ្ទាត់មិនត្រឹមត្រូវ។ សូមព្យាយាមម្តងទៀត។',
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
        // Clear all fields
        for (var controller in _controllers) {
          controller.clear();
        }
        _focusNodes[0].requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AuthHeader(title: _localizations.verifyCode),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _localizations.pleaseEnterCode,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _maskEmail(widget.email),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 45,
                        height: 50,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) => _onCodeChanged(index, value),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // Resend code logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _localizations.isEnglish
                                ? 'Verification code sent again'
                                : 'លេខកូដផ្ទៀងផ្ទាត់ត្រូវបានផ្ញើម្តងទៀត',
                          ),
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text(
                      _localizations.sendCodeAgain,
                      style: const TextStyle(
                        color: Colors.purple,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding:
                                const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            _localizations.back,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _verifyCode();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding:
                                const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            _localizations.next,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

