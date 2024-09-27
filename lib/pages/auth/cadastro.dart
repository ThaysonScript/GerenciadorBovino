import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Cadastro extends StatelessWidget {
  const Cadastro({super.key});

  // void listenToAuthState() {
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       print('User is currently signed out!');
  //     } else {
  //       print('User is signed in!');
  //     }
  //   });
  // }

  void _cadastrarUsuario(
      BuildContext context, String email, String senha) async {
    try {
      if (email.isNotEmpty && senha.isNotEmpty) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: senha,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Preencha todos os campos')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String email = '';
    String senha = '';
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
                      'CADASTRE UMA NOVA CONTA',
                      style: GoogleFonts.anton(
                          fontSize: 24, fontWeight: FontWeight.normal),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        onChanged: (value) => {
                          email = value
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), label: Text("Email")),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        onChanged: (value) => {
                          senha = value
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), label: Text("Senha")),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 65,
                      child: ElevatedButton(
                          onPressed: () => {_cadastrarUsuario(context, email, senha)},
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
