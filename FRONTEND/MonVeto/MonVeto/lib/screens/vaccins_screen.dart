// 📁 lib/screens/vaccins_screen.dart
import 'package:flutter/material.dart';

class VaccinsScreen extends StatefulWidget {
  const VaccinsScreen({super.key});

  @override
  _VaccinsScreenState createState() => _VaccinsScreenState();
}

class _VaccinsScreenState extends State<VaccinsScreen> {
  final List<Map<String, String>> _vaccins = [
    {'nom': 'Vaccin Chien A', 'date': '2025-04-10'},
    {'nom': 'Vaccin Chat B', 'date': '2025-04-12'},
    {'nom': 'Vaccin Lapin C', 'date': '2025-04-15'},
    {'nom': 'Vaccin Chien D', 'date': '2025-04-18'},
  ];

  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Méthode pour afficher le sélecteur de date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      // Formater la date au format YYYY-MM-DD
      setState(() {
        _dateController.text = '${selectedDate.toLocal()}'.split(' ')[0]; // Ex: 2025-04-20
      });
    }
  }

  // Ajout d'un vaccin
  void _addVaccin() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _vaccins.add({
          'nom': _nameController.text,
          'date': _dateController.text,
        });
      });
      Navigator.pop(context);
    }
  }

  // Modification d'un vaccin
  void _editVaccin(int index) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _vaccins[index] = {
          'nom': _nameController.text,
          'date': _dateController.text,
        };
      });
      Navigator.pop(context);
    }
  }

  // Suppression d'un vaccin
  void _deleteVaccin(int index) {
    setState(() {
      _vaccins.removeAt(index);
    });
  }

  // Formulaire d'ajout et de modification de vaccin
  void _showForm(BuildContext context, {int? index}) {
    if (index != null) {
      _nameController.text = _vaccins[index]['nom']!;
      _dateController.text = _vaccins[index]['date']!;
    } else {
      _nameController.clear();
      _dateController.clear();
    }

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nom du vaccin'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le nom du vaccin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16), // Espacement entre le TextField et le suivant
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'Date de vaccination'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer la date de vaccination';
                    }
                    return null;
                  },
                  readOnly: true, // Rendre ce champ en lecture seule
                  onTap: () => _selectDate(context), // Ouvrir le DatePicker lorsque l'on tape sur le champ
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (index == null) {
                      _addVaccin();
                    } else {
                      _editVaccin(index);
                    }
                  },
                  child: Text(index == null ? 'Ajouter' : 'Modifier'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _vaccins.length,
        itemBuilder: (context, index) {
          final vaccin = _vaccins[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(vaccin['nom']!),
              subtitle: Text(vaccin['date']!),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showForm(context, index: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteVaccin(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
