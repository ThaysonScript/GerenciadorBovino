import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/components/delay/navegation_delay.dart';
import 'package:gerenciador_bovino/components/layout/responsive_layout.dart';
import 'package:gerenciador_bovino/models/app_user.dart';
import 'package:gerenciador_bovino/pages/home.dart';
import 'package:gerenciador_bovino/pages/initial.dart';

class Apresentation extends StatelessWidget {
  Apresentation({super.key});

  AppUser usuario = AppUser();

  @override
  Widget build(BuildContext context) {
    usuario.name = "Thayson";
    usuario.email = "email";
    usuario.password = "123456";
    return NavigationDelay(
        delayDuration: const Duration(seconds: 3),
        // navigateTo: const Initial(),
        navigateTo: Home(usuario),
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 15, 34, 45),
            body: Center(
              child: Image.asset(
                "assets/images/gerenciador_bovino_logo.png",
                width: ResponsiveLayout.scaleWidth(300),
                height: ResponsiveLayout.scaleHeight(300),
              ),
            )));
  }
}
