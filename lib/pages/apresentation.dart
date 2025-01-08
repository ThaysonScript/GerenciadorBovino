import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/components/delay/navegation_delay.dart';
import 'package:gerenciador_bovino/components/layout/responsive_layout.dart';
import 'package:gerenciador_bovino/models/app_user.dart';
import 'package:gerenciador_bovino/pages/home.dart';
import 'package:gerenciador_bovino/pages/initial.dart';
import '../internal_assets/colors/cores_personalizadas.dart';

class Apresentation extends StatelessWidget {
  Apresentation({super.key});

  AppUser usuario = AppUser(
      id: Int(), nome: 'nome', email: 'dddudu@djdj.hddh', senha: '123456');

  @override
  Widget build(BuildContext context) {
    return NavigationDelay(
        delayDuration: const Duration(seconds: 3),
        // navigateTo: const Initial(),
        navigateTo: Home(usuario),
        child: Scaffold(
            backgroundColor: CoresPersonalizadas().blackBlue(),
            body: Center(
              child: Image.asset(
                "assets/images/gerenciador_bovino_logo.png",
                width: ResponsiveLayout.scaleWidth(300),
                height: ResponsiveLayout.scaleHeight(300),
              ),
            )));
  }
}
