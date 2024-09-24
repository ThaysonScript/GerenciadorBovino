import 'package:flutter/material.dart';

class Apresentacao extends StatelessWidget {
  const Apresentacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/gerenciador_bovino_logo.png"),
            fit: BoxFit.cover, // Preenche a tela sem distorcer
          ),
        ),
      ),
    );
  }
}
