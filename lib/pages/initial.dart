import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/pages/auth/register.dart';
import 'package:gerenciador_bovino/pages/auth/login.dart';
import 'package:google_fonts/google_fonts.dart';

class Initial extends StatelessWidget {
  const Initial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset("assets/images/bovino02.jpg"),
        Padding(
          padding: const EdgeInsets.only(top: 370),
          child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(235, 231, 217, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Gerenciador Bovino",
                      style: GoogleFonts.anton(
                          fontSize: 40, 
                          fontWeight: FontWeight.normal
                      )
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      '''
                        Lorem ipsum dolor sit amet. Est voluptas enim ut inventore voluptatem  sit magnam harum.
                        Non minima laboriosam ad pariatur omnis aut maiores  quaerat non dolores dolores.
                        Qui quos sunt et consequatur inventore id  suscipit delectus et dolores maiores.
                        ''',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.anton(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()))
                    },
                    child: Container(
                      width: 300,
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
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()))
                    },
                    child: Container(
                      width: 300,
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
                  )
                ],
              )),
        ),
      ],
    ));
  }
}
