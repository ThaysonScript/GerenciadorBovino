import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/components/widgets/date_field_widget.dart';
import 'package:gerenciador_bovino/components/widgets/image_picker_widget.dart';
import 'package:gerenciador_bovino/components/widgets/seletor_vacinas_widget.dart';
import 'package:gerenciador_bovino/components/widgets/text_field_widget.dart';
import 'package:gerenciador_bovino/database/repository/bovino_repository.dart';
import 'package:gerenciador_bovino/models/bovino.dart';
import 'package:gerenciador_bovino/models/vacina.dart';
import 'package:image_picker/image_picker.dart';

class BovinoRegister extends StatefulWidget {
  const BovinoRegister({super.key});

  @override
  _BovinoRegisterState createState() => _BovinoRegisterState();
}

class _BovinoRegisterState extends State<BovinoRegister> {
  final _formKey = GlobalKey<FormState>();
  late Bovino _bovino;

  final List<Vacina> _vacinasDisponiveis = [];
  final List<Vacina> _vacinasSelecionadas = [];
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _dataController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bovino = Bovino(
      nome: '',
      idade: 0,
      imagens: [],
      dataCompra: DateTime.now(),
      peso: 0.0,
      precoCompra: 0.0,
      vacinas: [],
      acessorios: [],
      timestamp: DateTime.now(),
    );
    _dataController.text = "";
    _fetchVacinas();
  }

  Future<void> _fetchVacinas() async {
    try {
      bool isConnected = await _hasInternetConnection();
      if (isConnected) {
        // TODO: Adicionar lógica para carregar vacinas do Firebase
      } else {
        // TODO: Adicionar lógica para carregar vacinas do SQLite
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar vacinas: $e')),
      );
    }
  }

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
        title: const Text('Registro de Bovino'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldWidget(
                  label: 'Nome do Bovino',
                  validationMessage: 'Insira o nome',
                  icon: Icons.pets,
                  onSaved: (value) => _bovino.nome = value ?? '',
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 24.0),
                TextFieldWidget(
                  label: 'Idade',
                  validationMessage: 'Insira a idade',
                  icon: Icons.cake,
                  onSaved: (value) => _bovino.idade = int.tryParse(value ?? '') ?? 0,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24.0),
                TextFieldWidget(
                  label: 'Preço (R\$)',
                  validationMessage: 'Insira o preço de compra',
                  icon: Icons.fitness_center,
                  onSaved: (value) => _bovino.precoCompra = double.tryParse(value ?? '') ?? 0.0,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24.0),
                TextFieldWidget(
                  label: 'Peso (kg)',
                  validationMessage: 'Insira o peso',
                  icon: Icons.fitness_center,
                  onSaved: (value) => _bovino.peso = double.tryParse(value ?? '') ?? 0.0,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24.0),
                DateFieldWidget(
                  label: 'Data de Compra',
                  validationMessage: 'Insira a data de compra',
                  icon: Icons.calendar_today,
                  onSaved: (value) {
                    setState(() {
                      _bovino.dataCompra = DateTime.tryParse(value ?? '') ?? DateTime.now();
                    });
                  },
                  controller: _dataController,
                  onTap: _pickDate,
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 32, bottom: 32),
                    child: Text('Insira imagens do animal'),
                  ),
                ),
                ImagePickerWidget(onPickImage: _pickImage),
                if (_bovino.imagens.isNotEmpty) _buildImagePreview(),
                const SizedBox(height: 32.0),
                SeletorVacinasWidget(
                  vacinasDisponiveis: _vacinasDisponiveis,
                  vacinasSelecionadas: _vacinasSelecionadas,
                  onVaccinaChanged: _onVaccinaChanged,
                ),
                const SizedBox(height: 32.0),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source, imageQuality: 50);
      if (pickedFile != null) {
        setState(() {
          _bovino.imagens.add(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint('Erro ao capturar imagem: $e');
    }
  }

  void _onVaccinaChanged(Vacina vacina, bool selected) {
    setState(() {
      if (selected) {
        _vacinasSelecionadas.add(vacina);
      } else {
        _vacinasSelecionadas.remove(vacina);
      }
    });
  }

  Future<void> _pickDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _bovino.dataCompra,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _bovino.dataCompra = selectedDate;
        _dataController.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }

  Widget _buildSaveButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await BovinoRepository().saveBovino(_formKey, _bovino);
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: const Text('Salvar Bovino'),
      ),
    );
  }

    Widget _buildImagePreview() {
    if (_bovino.imagens.isEmpty) {
      return const SizedBox(); // Retorna um widget vazio se não houver imagens.
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: _bovino.imagens.map((path) {
          final file = File(path); // Caminho da imagem
          if (!file.existsSync()) {
            return const Text('Erro: Imagem não encontrada');
          }
          return Image.file(
            file,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          );
        }).toList(),
      ),
    );
  }
}
