import 'package:flutter/material.dart';
import 'package:hotel_app/core/constants/app_constants.dart';
import 'package:hotel_app/core/localization/app_localizations.dart';
import 'package:hotel_app/core/services/language_service.dart';
import 'package:hotel_app/features/home/views/home_view.dart';
import 'package:hotel_app/features/cart/views/cart_view.dart';
import 'package:hotel_app/features/favorites/views/favorites_view.dart';
import 'package:hotel_app/features/profile/views/profile_view.dart';

/// Main Screen with Bottom Navigation
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final LanguageService _languageService = LanguageService();
  final AppLocalizations _localizations = AppLocalizations();
  int _currentIndex = AppConstants.homeTabIndex;

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

  Widget _getScreen(int index) {
    switch (index) {
      case AppConstants.homeTabIndex:
        return const HomeView();
      case AppConstants.cartTabIndex:
        return const CartView();
      case AppConstants.favoritesTabIndex:
        return const FavoritesView();
      case AppConstants.profileTabIndex:
        return const ProfileView();
      default:
        return const HomeView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(_currentIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: _localizations.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart_outlined),
              activeIcon: const Icon(Icons.shopping_cart),
              label: _localizations.cart,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_outline),
              activeIcon: const Icon(Icons.favorite),
              label: _localizations.favorites,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              label: _localizations.profile,
            ),
          ],
        ),
      ),
    );
  }
}

