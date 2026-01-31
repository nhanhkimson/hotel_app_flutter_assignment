import 'dart:async';
import 'package:flutter/material.dart';

class SuccessChangePasswordScreen extends StatefulWidget {
  const SuccessChangePasswordScreen({super.key});

  @override
  State<SuccessChangePasswordScreen> createState() =>
      _SuccessChangePasswordScreenState();
}

class _SuccessChangePasswordScreenState
    extends State<SuccessChangePasswordScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.lightBlue,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Password changed successfully!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Your password has been changed successfully. You will be redirected to your profile shortly.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
