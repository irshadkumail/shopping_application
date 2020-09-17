import 'package:flutter/material.dart';

InputBorder getInputFieldBorder() {
  return OutlineInputBorder(borderSide: BorderSide(color: Colors.amber));
}

String validateEmptyString(String input) {
  if (input != null && input.isNotEmpty) return null;
  return "Mandatory Field";
}
