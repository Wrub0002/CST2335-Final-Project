import 'package:flutter/material.dart';

/// A utility class for displaying custom Snackbars in the application.
class CustomSnackbar {
  /// Displays a Snackbar with the given [message] in the provided [context].
  static void show(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.blueGrey,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
