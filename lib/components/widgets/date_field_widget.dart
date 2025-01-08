import 'package:flutter/material.dart';

class DateFieldWidget extends StatelessWidget {
  final String label;
  final String validationMessage;
  final IconData icon;
  final Function(String?) onSaved;
  final TextEditingController controller;
  final Function() onTap;

  const DateFieldWidget({
    super.key,
    required this.label,
    required this.validationMessage,
    required this.icon,
    required this.onSaved,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        keyboardType: TextInputType.datetime,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationMessage;
          }
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }
}
