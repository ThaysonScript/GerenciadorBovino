import 'package:flutter/material.dart';

class Initial extends StatelessWidget {
  const Initial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/images/bovino02.jpg",
                height: 500, // Altura da imagem
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            top: 455,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),

              child: const Column(
                children: [
                  Text("Gerenciador Bovino",
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
