import 'package:flutter/material.dart';
// import 'package:gerenciador_bovino/facade/firebase_facade.dart';
import 'package:gerenciador_bovino/models/app_user.dart';
import 'package:gerenciador_bovino/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // final AppUser user = AppUser(uid: null, name: '', email: '', password: '');
  // final FirebaseFacade firebaseFacade = FirebaseFacade();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String errorMessage = '';

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
                  topRight: Radius.circular(30),
                ),
              ),
              child: Form(
                key: _formKey,
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
                      child: TextFormField(
                        // onChanged: (value) => user.name = value,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Nome"),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira seu nome';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        // onChanged: (value) => user.email = value,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Email"),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um email';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                              .hasMatch(value)) {
                            return 'Por favor, insira um email válido';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        obscureText: true,
                        // onChanged: (value) => user.password = value,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Senha"),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira uma senha';
                          } else if (value.length < 6) {
                            return 'A senha deve ter pelo menos 6 caracteres';
                          }
                          return null;
                        },
                      ),
                    ),
                    if (errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    SizedBox(
                      width: 300,
                      height: 65,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  // try {
                                  //   // Realizando o cadastro
                                  //   await firebaseFacade.register(
                                  //     context,
                                  //     user.email ?? '',
                                  //     user.password ?? '',
                                  //   );
                                  //   firebaseFacade
                                  //       .register(
                                  //           context, user.email, user.password)
                                  //       .then((appUser) {
                                  //     if (appUser != null) {
                                  //       Navigator.pushReplacement(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 Home(appUser)),
                                  //       );
                                  //     }
                                  //   });
                                  // } catch (e) {
                                  //   setState(() {
                                  //     errorMessage = 'Erro ao cadastrar: $e';
                                  //   });
                                  // } finally {
                                  //   setState(() {
                                  //     isLoading = false;
                                  //   });
                                  // }
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 42, 60, 71),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "CADASTRAR",
                                style: GoogleFonts.anton(
                                  fontSize: 35,
                                  color:
                                      const Color.fromARGB(255, 235, 231, 217),
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
