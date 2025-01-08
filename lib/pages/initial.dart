import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/components/gestures/gestures.dart';
import 'package:gerenciador_bovino/components/layout/responsive_layout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gerenciador_bovino/pages/auth/register.dart';
import 'package:gerenciador_bovino/pages/auth/login.dart';

class Initial extends StatelessWidget {
  const Initial({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveLayout.init(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                  width: ResponsiveLayout.scaleWidth(700),
                  height: ResponsiveLayout.scaleHeight(450),
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "Gerenciador Bovino",
                        style: GoogleFonts.anton(
                          fontSize: 40,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                Gestures(
                    cor: Colors.amber,
                    texto: 'Login',
                    acaoClique: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    }),
                const SizedBox(height: 20),
                Gestures(
                    cor: Colors.amber,
                    texto: 'Cadastro',
                    acaoClique: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    }),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: ResponsiveLayout.scaleWidth(280),
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.g_mobiledata, // Ícone representando o Google
                          size: 60,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Login com Google",
                          style: GoogleFonts.anton(
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
