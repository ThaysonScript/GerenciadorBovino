import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/models/vacina.dart';

class SeletorVacinasWidget extends StatelessWidget {
  final List<Vacina> vacinasDisponiveis;
  final List<Vacina> vacinasSelecionadas;
  final Function(Vacina, bool) onVaccinaChanged;

  const SeletorVacinasWidget({
    super.key,
    required this.vacinasDisponiveis,
    required this.vacinasSelecionadas,
    required this.onVaccinaChanged,
  });

  @override
  Widget build(BuildContext context) {
    return vacinasDisponiveis.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            shrinkWrap: true,
            itemCount: vacinasDisponiveis.length,
            itemBuilder: (context, index) {
              final vacina = vacinasDisponiveis[index];
              return CheckboxListTile(
                title: Text(vacina.nome),
                value: vacinasSelecionadas.contains(vacina),
                onChanged: (bool? selected) {
                  onVaccinaChanged(vacina, selected ?? false);
                },
              );
            },
          );
  }
}
