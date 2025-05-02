// 📁 lib/screens/rendezvous_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RendezVousScreen extends StatefulWidget {
  const RendezVousScreen({super.key});

  @override
  State<RendezVousScreen> createState() => _RendezVousScreenState();
}

class _RendezVousScreenState extends State<RendezVousScreen> {
  List<Map<String, String>> rendezVous = [
    {'date': '2025-04-20', 'heure': '10:00', 'client': 'Alice Dupont', 'animal': 'Chien'},
    {'date': '2025-04-21', 'heure': '14:00', 'client': 'Jean Martin', 'animal': 'Chat'},
  ];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _heureController = TextEditingController();
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _animalController = TextEditingController();
  int? _editingIndex;

  @override
  void dispose() {
    _dateController.dispose();
    _heureController.dispose();
    _clientController.dispose();
    _animalController.dispose();
    super.dispose();
  }

  void _openForm({int? index}) {
    if (index != null) {
      final item = rendezVous[index];
      _dateController.text = item['date']!;
      _heureController.text = item['heure']!;
      _clientController.text = item['client']!;
      _animalController.text = item['animal']!;
      _editingIndex = index;
    } else {
      _dateController.clear();
      _heureController.clear();
      _clientController.clear();
      _animalController.clear();
      _editingIndex = null;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(_editingIndex == null ? 'Ajouter un rendez-vous' : 'Modifier le rendez-vous'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Date'),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
                    }
                  },
                  validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _heureController,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Heure'),
                  onTap: () async {
                    TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null) {
                      _heureController.text = picked.format(context);
                    }
                  },
                  validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _clientController,
                  decoration: const InputDecoration(labelText: 'Nom du client'),
                  validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _animalController,
                  decoration: const InputDecoration(labelText: 'Animal'),
                  validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final newEntry = {
                  'date': _dateController.text,
                  'heure': _heureController.text,
                  'client': _clientController.text,
                  'animal': _animalController.text,
                };
                setState(() {
                  if (_editingIndex != null) {
                    rendezVous[_editingIndex!] = newEntry;
                  } else {
                    rendezVous.add(newEntry);
                  }
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Enregistrer'),
          )
        ],
      ),
    );
  }

  void _deleteRendezVous(int index) {
    setState(() {
      rendezVous.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: rendezVous.length,
        itemBuilder: (context, index) {
          final item = rendezVous[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.schedule, color: Colors.green),
              title: Text('${item['client']} - ${item['animal']}'),
              subtitle: Text('${item['date']} à ${item['heure']}'),
              trailing: Wrap(
                spacing: 12,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () => _openForm(index: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteRendezVous(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
