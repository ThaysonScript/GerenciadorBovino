import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/components/forms/login_form.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String errorMessage = '';

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });
      // Simulação de login ou processamento
      await Future.delayed(const Duration(seconds: 2)); // Simulação
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 42, 60, 71),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 235, 231, 217),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 42, 60, 71),
          ),
          LoginForm(
            formKey: _formKey,
            isLoading: isLoading,
            errorMessage: errorMessage,
            onLogin: _login,
          ),
        ],
      ),
    );
  }
}
