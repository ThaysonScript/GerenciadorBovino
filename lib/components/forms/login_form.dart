import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/components/buttons/custom_button.dart';
import 'package:gerenciador_bovino/components/forms/custom_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final String errorMessage;
  final Future<void> Function()? onLogin;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.isLoading,
    required this.errorMessage,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 250),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 235, 231, 217),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'ENTRE COM A SUA CONTA',
                style: GoogleFonts.anton(fontSize: 24),
              ),
              CustomTextField(
                label: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um email';
                  }
                  return null;
                },
              ),
              CustomTextField(
                label: 'Senha',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma senha';
                  }
                  return null;
                },
              ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              CustomButton(
                label: 'ENTRAR',
                isLoading: isLoading,
                onPressed: onLogin ?? () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
