import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String validationMessage;
  final IconData icon;
  final Function(String?) onSaved;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? filteringText;

  const TextFieldWidget({
    super.key,
    required this.label,
    required this.validationMessage,
    required this.icon,
    required this.onSaved,
    required this.keyboardType,
    this.filteringText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        return null;
      },
      onSaved: onSaved,
      keyboardType: keyboardType,
      inputFormatters: filteringText,
    );
  }
}
