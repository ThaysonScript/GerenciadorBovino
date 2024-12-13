import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/pages/auth/register.dart';
import 'package:gerenciador_bovino/pages/auth/login.dart';
import 'package:google_fonts/google_fonts.dart';

class Initial extends StatelessWidget {
  const Initial({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(235, 231, 217, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/bovino02.jpg",
                    width: screenWidth,
                    height: screenHeight * 0.46, // 40% da altura da tela
                    fit: BoxFit.cover,
                  ),
                  Text(
                    "Gerenciador Bovino",
                    style: GoogleFonts.anton(
                      fontSize: 40,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '''
                        Lorem ipsum dolor sit amet. Est voluptas enim ut inventore voluptatem sit magnam harum.
                        Non minima laboriosam ad pariatur omnis aut maiores quaerat non dolores dolores.
                        Qui quos sunt et consequatur inventore id suscipit delectus et dolores maiores.
                        ''',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.anton(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    ),
                    child: Container(
                      width: screenWidth * 0.7, // 70% da largura da tela
                      height: 60,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.amber,
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: GoogleFonts.anton(fontSize: 35),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    ),
                    child: Container(
                      width: screenWidth * 0.7, // 70% da largura da tela
                      height: 60,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.amber,
                      ),
                      child: Center(
                        child: Text(
                          "Cadastro",
                          style: GoogleFonts.anton(fontSize: 35),
                        ),
                      ),
                    ),
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
