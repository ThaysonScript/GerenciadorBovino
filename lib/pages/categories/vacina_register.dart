import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/db/database_helper.dart';
import 'package:gerenciador_bovino/models/vacina.dart';

class VacinaRegister extends StatefulWidget {
  const VacinaRegister({super.key});

  @override
  _VacinaRegisterState createState() => _VacinaRegisterState();
}

class _VacinaRegisterState extends State<VacinaRegister> {
  String _nome = '';
  String _data = '';
  List<Vacina> _vacinas = [];

  @override
  void initState() {
    super.initState();
    _carregarVacinas();
  }

  Future<void> _carregarVacinas() async {
    List<Vacina> vacinas = await DatabaseHelper().getVacinas();
    setState(() {
      _vacinas = vacinas;
    });
  }

  Future<void> _salvarVacina() async {
    if (_nome.isNotEmpty && _data.isNotEmpty) {
      Vacina vacina = Vacina(nome: _nome, data: _data);
      await DatabaseHelper().insertVacina(vacina);
      _nome = '';
      _data = '';
      _carregarVacinas(); // Atualiza a lista após inserir
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
    }
  }

  Future<void> _editarVacina(Vacina vacina) async {
    setState(() {
      _nome = vacina.nome;
      _data = vacina.data;
    });
    await DatabaseHelper().deleteVacina(vacina.id!); // Exclui a vacina antiga
    _salvarVacina(); // Salva a vacina editada
  }

  Future<void> _deletarVacina(int id) async {
    await DatabaseHelper().deleteVacina(id);
    _carregarVacinas(); // Atualiza a lista após deletar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar Vacinas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _nome = value;
                });
              },
              decoration: InputDecoration(labelText: 'Nome da Vacina'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _data = value;
                });
              },
              decoration: InputDecoration(labelText: 'Data da Vacina'),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvarVacina,
              child: Text('Salvar Vacina'),
            ),
            const SizedBox(height: 20),
            const Text('Vacinas Salvas:', style: TextStyle(fontSize: 18)),
            Expanded(
              child: ListView.builder(
                itemCount: _vacinas.length,
                itemBuilder: (context, index) {
                  final vacina = _vacinas[index];
                  return ListTile(
                    title: Text(vacina.nome),
                    subtitle: Text(vacina.data),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editarVacina(vacina),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deletarVacina(vacina.id!),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
