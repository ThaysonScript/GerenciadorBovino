import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/facade/firebase_facade.dart';
import 'package:gerenciador_bovino/models/app_user.dart';
import 'package:gerenciador_bovino/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  AppUser user = AppUser();
  final firebaseFacade = FirebaseFacade();

  Login({super.key});

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
            Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 235, 231, 217),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'ENTRE COM A SUA CONTA',
                      style: GoogleFonts.anton(
                          fontSize: 24, fontWeight: FontWeight.normal),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        onChanged: (value) => {user.email = value},
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), label: Text("Email")),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        onChanged: (value) => {user.password = value},
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), label: Text("Senha")),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 65,
                      child: ElevatedButton(
                          onPressed: () => {
                                firebaseFacade.login(
                                    context, user.email, user.password),
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home(user)))
                              },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 42, 60, 71),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text(
                            "ENTRAR",
                            style: GoogleFonts.anton(
                              fontSize: 35,
                              color: const Color.fromARGB(255, 235, 231, 217),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
