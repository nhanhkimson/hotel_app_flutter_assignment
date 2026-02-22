import 'package:flutter/material.dart';
import 'package:hotel_app/shared/widgets/image_widget.dart';

/// Shared header widget for auth screens
class AuthHeader extends StatelessWidget {
  final String title;
  final double? height;

  const AuthHeader({
    super.key,
    required this.title,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange[300]!,
            Colors.pink[300]!,
            Colors.purple[300]!,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: ImageWidget(
              imageUrl: 'assets/static/Hotel/hotel_sunset_paradise.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          // Dark overlay
          Container(
            color: Colors.black.withValues(alpha: 0.3),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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

