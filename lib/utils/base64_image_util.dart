import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class Base64ImageUtil {
  /// Converts a base64 string to an Image widget
  /// Handles errors and invalid data safely
  static Widget fromBase64String(
    String base64String, {
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
    Widget? errorWidget,
  }) {
    try {
      // Remove data URI prefix if exists
      final cleanedBase64 = base64String.contains(',')
          ? base64String.split(',').last
          : base64String;

      // Decode base64 to bytes
      Uint8List imageBytes = base64Decode(cleanedBase64);

      return Image.memory(
        imageBytes,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ??
              Icon(
                Icons.broken_image,
                size: 50,
                color: Colors.grey,
              );
        },
      );
    } catch (e) {
      // If decoding or rendering fails
      return errorWidget ??
          Icon(
            Icons.error_outline,
            size: 50,
            color: Colors.red,
          );
    }
  }
}
