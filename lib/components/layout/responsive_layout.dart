import 'package:flutter/material.dart';

class ResponsiveLayout {
  static late double screenWidth;
  static late double screenHeight;

  /// Inicializa o escalonador com os tamanhos do dispositivo.
  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
  }

  /// Escala o valor proporcionalmente à largura da tela.
  static double scaleWidth(double value) => value * screenWidth / 375; // 375 é um valor base genérico.

  /// Escala o valor proporcionalmente à altura da tela.
  static double scaleHeight(double value) => value * screenHeight / 812; // 812 é um valor base genérico.

  /// Escala o tamanho do texto proporcionalmente à largura da tela.
  static double scaleText(double fontSize) => scaleWidth(fontSize);
}
