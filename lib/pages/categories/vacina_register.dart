import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/models/vacina.dart';
// import 'package:gerenciador_bovino/db/database_helper.dart';
// import 'package:gerenciador_bovino/facade/firebase_facade.dart';

class VacinaRegister extends StatefulWidget {
  final String? bovinoId; // ID do bovino para vincular a vacina a ele
  const VacinaRegister({super.key, this.bovinoId});

  @override
  _VacinaRegisterState createState() => _VacinaRegisterState();
}

class _VacinaRegisterState extends State<VacinaRegister> {
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  String _data = '';

  Future<void> _saveVacina() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();

    // Converter _data para DateTime (se for uma string)
    DateTime dataVacina = DateTime.tryParse(_data) ?? DateTime.now();

    // Criar a vacina com o valor correto de data
    // Vacina vacina = Vacina(
    //   nome: _nome,
    //   data: dataVacina,
    //   id: '', // O ID será atribuído pelo Firestore ou SQLite
    // );

    // final dbHelper = DatabaseHelper();

    if (!Platform.isLinux) {
      // Verificar conectividade antes de salvar no Firebase
      bool isConnected = await _hasInternetConnection();
      if (isConnected) {
        try {
          // final firebaseFacade = FirebaseFacade();

          // Salvar vacina no Firestore e obter o ID gerado
          // final vacinaId = await firebaseFacade.saveVacinaToFirestore(vacina, widget.bovinoId ?? '');

          // Relacionar vacina com o bovino no Firebase
          // await firebaseFacade.linkVacinaToBovino(
          //     widget.bovinoId ?? '', vacinaId);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Vacina salva no Firebase com sucesso!')),
          );
        } catch (e) {
          print('Erro ao salvar no Firebase: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao salvar no Firebase. Salvando localmente.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sem conexão. Salvando apenas localmente!')),
        );
      }
    } else {
      print('Linux detectado: Usando SQLite.');
    }

    // Salvar vacina no SQLite
    try {
      // Passar o bovinoId ao salvar a vacina
      // await dbHelper.insertVacina(vacina, widget.bovinoId ?? '');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vacina salva localmente com sucesso!')),
      );
    } catch (e) {
      print('Erro ao salvar no SQLite: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao salvar localmente.')),
      );
    }

    // Retornar à tela anterior
    Navigator.pop(context);
  }
}


// Método para verificar conectividade
  Future<bool> _hasInternetConnection() async {
    try {
      final result = await Connectivity().checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Vacina'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome da Vacina'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome da vacina';
                  }
                  return null;
                },
                onSaved: (value) => _nome = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Data da Vacina'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a data da vacina';
                  }
                  return null;
                },
                onSaved: (value) => _data = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveVacina,
                child: const Text('Salvar Vacina'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
