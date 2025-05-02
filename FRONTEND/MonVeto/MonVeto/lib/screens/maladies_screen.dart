// 📁 lib/screens/maladies_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MaladiesScreen extends StatefulWidget {
  const MaladiesScreen({super.key});

  @override
  _MaladiesScreenState createState() => _MaladiesScreenState();
}

class _MaladiesScreenState extends State<MaladiesScreen> {
  final List<Map<String, String>> _maladies = [
    {'nom': 'Maladie Chien A', 'date': '2025-04-10'},
    {'nom': 'Maladie Chat B', 'date': '2025-04-12'},
    {'nom': 'Maladie Lapin C', 'date': '2025-04-15'},
  ];

  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Sélecteur de date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  // Ajouter une maladie
  void _addMaladie() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _maladies.add({
          'nom': _nameController.text,
          'date': _dateController.text,
        });
      });
      Navigator.pop(context);
    }
  }

  // Modifier une maladie
  void _editMaladie(int index) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _maladies[index] = {
          'nom': _nameController.text,
          'date': _dateController.text,
        };
      });
      Navigator.pop(context);
    }
  }

  // Supprimer une maladie
  void _deleteMaladie(int index) {
    setState(() {
      _maladies.removeAt(index);
    });
  }

  // Afficher le formulaire pour ajouter ou modifier une maladie
  void _showForm(BuildContext context, {int? index}) {
    if (index != null) {
      _nameController.text = _maladies[index]['nom']!;
      _dateController.text = _maladies[index]['date']!;
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
                  decoration: const InputDecoration(labelText: 'Nom de la maladie'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le nom de la maladie';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'Date de diagnostic'),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer la date de diagnostic';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (index == null) {
                      _addMaladie();
                    } else {
                      _editMaladie(index);
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
        itemCount: _maladies.length,
        itemBuilder: (context, index) {
          final maladie = _maladies[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(maladie['nom']!),
              subtitle: Text(maladie['date']!),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showForm(context, index: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteMaladie(index),
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
