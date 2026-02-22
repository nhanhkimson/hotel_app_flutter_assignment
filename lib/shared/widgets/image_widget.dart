import 'package:flutter/material.dart';

/// Reusable image widget with placeholder fallback
class ImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const ImageWidget({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // Debug: Print image URL to help identify issues
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      debugPrint('ImageWidget: Attempting to load image: $imageUrl');
    }
    
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? Image.asset(
              imageUrl!,
              width: width,
              height: height,
              fit: fit,
              errorBuilder: (context, error, stackTrace) {
                // Debug: Print error to help identify issues
                debugPrint('ImageWidget Error: Failed to load image: $imageUrl');
                debugPrint('Error details: $error');
                return _buildPlaceholder();
              },
            )
          : _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: borderRadius,
      ),
      child: Center(
        child: Icon(
          Icons.hotel,
          size: (height != null && height! < 100) ? 40 : 50,
          color: Colors.blue[300],
        ),
      ),
    );
  }
}

