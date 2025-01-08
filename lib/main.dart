import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/components/layout/responsive_layout.dart';
import 'package:gerenciador_bovino/database/sqlite_database.dart';
import 'package:gerenciador_bovino/pages/apresentation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'firebase_options.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    sqfliteFfiInit(); // Inicializa o suporte FFI para SQLite no Linux
    databaseFactory = databaseFactoryFfi; // Define o factory para FFI

    await SqliteDatabase.instance.database;
    
    if (!Platform.isLinux) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
    
  } catch (e) {
    print(e);
  }

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          ResponsiveLayout.init(context);
          return Apresentation();
        },
      ),
    );
  }
}
