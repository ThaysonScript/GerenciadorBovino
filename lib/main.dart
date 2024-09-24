import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/pages/apresentacao.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "gerenciador_bovino",
      theme: ThemeData.dark(useMaterial3: true),
      home: const Apresentacao(),
    );
  }
}
