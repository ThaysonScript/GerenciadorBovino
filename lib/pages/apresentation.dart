import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/pages/initial.dart';

class Apresentation extends StatefulWidget {
  const Apresentation({super.key});

  @override
  _ApresentationState createState() => _ApresentationState();
}

class _ApresentationState extends State<Apresentation> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const Initial())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 34, 45),
      body: Center(
        child: Image.asset("assets/images/gerenciador_bovino_logo.png"),
      )
    );
  }
}
