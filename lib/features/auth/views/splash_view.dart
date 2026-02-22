import 'package:flutter/material.dart';
import 'package:hotel_app/core/constants/app_constants.dart';
import 'package:hotel_app/core/main_screen.dart';
import 'package:hotel_app/core/services/auth_service.dart';
import 'package:hotel_app/features/auth/views/sign_in_view.dart';

/// Splash View
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  _navigateToNext() async {
    await Future.delayed(AppConstants.splashDelay);
    if (mounted) {
      // Check if user is logged in
      if (_authService.isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInView()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppConstants.appLogoPath,
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            Text(
              AppConstants.appName,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.brown[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

