import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/db/database_helper.dart';
import 'package:gerenciador_bovino/models/bovino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class BovinoRegister extends StatefulWidget {
  const BovinoRegister({super.key});

  @override
  _BovinoRegisterState createState() => _BovinoRegisterState();
}

class _BovinoRegisterState extends State<BovinoRegister> {
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  String _idade = '';
  String _peso = '';
  String _imagem = '';
  XFile? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    _imageFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (_imageFile != null) {
      setState(() {
        _imagem = _imageFile!.path;
      });
    }
  }

  Future<void> _pickGalleryImage() async {
    final picker = ImagePicker();
    _imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (_imageFile != null) {
      setState(() {
        _imagem = _imageFile!.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          title: const Text('Registro de Bovino',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          backgroundColor: Colors.teal,
          elevation: 0,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField('Nome do Bovino', 'Insira o nome', Icons.pets,
                    (value) {
                  _nome = value!;
                }),
                const SizedBox(height: 24.0),
                _buildTextField('Idade', 'Insira a idade', Icons.cake, (value) {
                  _idade = value!;
                }),
                const SizedBox(height: 24.0),
                _buildTextField(
                    'Peso (kg)', 'Insira o peso', Icons.fitness_center,
                    (value) {
                  _peso = value!;
                }),
                const SizedBox(height: 32.0),
                _buildImagePickerButtons(),
                if (_imagem.isNotEmpty) _buildImagePreview(),
                const SizedBox(height: 32.0),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String validationMessage, IconData icon,
      Function(String?) onSaved) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[700], fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.teal, width: 2),
          borderRadius: BorderRadius.circular(30.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        prefixIcon: Icon(icon, color: Colors.teal),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        return null;
      },
      onSaved: onSaved,
    );
  }

  Widget _buildImagePickerButtons() {
    return Column(
      children: [
        _buildButton('Tirar Foto', Colors.teal, _pickImage),
        const SizedBox(height: 16.0),
        _buildButton(
            'Selecionar da Galeria', Colors.orangeAccent, _pickGalleryImage),
      ],
    );
  }

  Widget _buildButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      child: Text(label),
    );
  }

  Widget _buildImagePreview() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Text('Imagem Selecionada',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700])),
        const SizedBox(height: 8.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.file(
            File(_imagem),
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _saveBovino,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      child: const Text('Salvar Bovino'),
    );
  }

  void _saveBovino() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Definindo a data de cadastro
      String dataCadastro = Bovino.getCurrentDate(); // Obtendo a data atual

      // Criando o objeto Bovino
      final bovino = Bovino(
        nome: _nome,
        idade: _idade,
        peso: _peso,
        imagem: _imagem,
        vacinas: [], // Lista de vacinas vazia ou populada conforme necessário
        dataCadastro: dataCadastro, // Atribuindo a data de cadastro
      );

      // Salvar no banco de dados
      final dbHelper = DatabaseHelper();
      await dbHelper.insertBovino(bovino);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bovino salvo com sucesso!')),
      );

      Navigator.pop(context);
    }
  }
}
