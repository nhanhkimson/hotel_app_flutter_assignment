import 'package:flutter/material.dart';
import 'package:hotel_app/core/localization/app_localizations.dart';
import 'package:hotel_app/core/services/auth_service.dart';
import 'package:hotel_app/core/services/language_service.dart';
import 'package:hotel_app/core/services/user_service.dart';
import 'package:hotel_app/features/auth/views/sign_in_view.dart';
import 'package:hotel_app/features/profile/views/language_selection_view.dart';
import 'package:hotel_app/features/profile/views/my_profile_view.dart';
import 'package:hotel_app/features/profile/views/password_security_view.dart';
import 'package:hotel_app/features/profile/views/transaction_history_view.dart';
import 'package:hotel_app/shared/widgets/menu_item.dart';

/// Profile View
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final LanguageService _languageService = LanguageService();
  final AppLocalizations _localizations = AppLocalizations();
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

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

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_localizations.logout),
          content: Text(_localizations.areYouSureLogout),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(_localizations.cancel),
            ),
            TextButton(
              onPressed: () {
                _authService.logout();
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInView(),
                  ),
                  (route) => false,
                );
              },
              child: Text(
                _localizations.logout,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = _languageService.isEnglish;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          isEnglish ? 'Profile' : 'ប្រូហ្វាល',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildMenuItems(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    final userInfo = _userService.getUserInfo();
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.person, size: 40, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userInfo['fullName'] ?? 'User',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userInfo['email'] ?? 'user@example.com',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    final isEnglish = _languageService.isEnglish;
    final currentLangName = _languageService.getLanguageName(_languageService.currentLanguage);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          MenuItem(
            icon: Icons.person,
            title: isEnglish ? 'My Profile' : 'ប្រូហ្វាលរបស់ខ្ញុំ',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyProfileView(),
                ),
              );
            },
          ),
          MenuItem(
            icon: Icons.lock,
            title: isEnglish ? 'Password and Security' : 'ពាក្យសម្ងាត់ និងសុវត្ថិភាព',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PasswordSecurityView(),
                ),
              );
            },
          ),
          MenuItem(
            icon: Icons.description,
            title: isEnglish ? 'Transaction History' : 'ប្រវត្តិប្រតិបត្តិការ',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TransactionHistoryView(),
                ),
              );
            },
          ),
          MenuItem(
            icon: Icons.language,
            title: '${isEnglish ? 'Language' : 'ភាសា'} ($currentLangName)',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LanguageSelectionView(),
                ),
              );
            },
          ),
          MenuItem(
            icon: Icons.chat_bubble_outline,
            title: 'FQA',
            onTap: () {},
          ),
          MenuItem(
            icon: Icons.info_outline,
            title: isEnglish ? 'About App' : 'អំពីកម្មវិធី',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          MenuItem(
            icon: Icons.logout,
            title: _localizations.logout,
            onTap: () {
              _handleLogout(context);
            },
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }
}

