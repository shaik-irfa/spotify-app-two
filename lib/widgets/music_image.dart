import 'package:flutter/material.dart';

class MusicImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;
  final Color placeholderColor;

  const MusicImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderColor = const Color(0xFF1A1A1A),
  });

  @override
  Widget build(BuildContext context) {
    final url = imageUrl.trim();

    if (url.isEmpty) {
      return _placeholder();
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            color: placeholderColor,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: Colors.green,
              strokeWidth: 2,
            ),
          );
        },
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      color: placeholderColor,
      alignment: Alignment.center,
      child: const Icon(
        Icons.music_note,
        color: Colors.white54,
        size: 28,
      ),
    );
  }
}
