import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration primary(String hintText) => InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: hintText,
      );
}
