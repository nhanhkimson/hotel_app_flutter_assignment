import 'package:flutter/material.dart';

/// Social login button widget
class SocialLoginButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback? onPressed;

  const SocialLoginButton({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[300]!),
        color: Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed ?? () {},
          borderRadius: BorderRadius.circular(25),
          child: Center(child: icon),
        ),
      ),
    );
  }
}

/// Google button with 'G' text
class GoogleButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const GoogleButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SocialLoginButton(
      label: 'Google',
      icon: const Text(
        'G',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
      onPressed: onPressed,
    );
  }
}

/// Facebook button with 'f' text
class FacebookButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const FacebookButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SocialLoginButton(
      label: 'Facebook',
      icon: const Text(
        'f',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
      onPressed: onPressed,
    );
  }
}

/// GitHub button with octocat icon
class GitHubButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const GitHubButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SocialLoginButton(
      label: 'GitHub',
      icon: const Icon(
        Icons.code,
        color: Colors.grey,
        size: 20,
      ),
      onPressed: onPressed,
    );
  }
}

