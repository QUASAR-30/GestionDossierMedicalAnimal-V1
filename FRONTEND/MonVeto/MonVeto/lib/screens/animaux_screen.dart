
// lib/screens/animaux_screen.dart

import 'package:flutter/material.dart';

class AnimauxScreen extends StatefulWidget {
  const AnimauxScreen({super.key});

  @override
  State<AnimauxScreen> createState() => _AnimauxScreenState();
}

class _AnimauxScreenState extends State<AnimauxScreen> {
  final List<Map<String, String>> _animaux = [
    {'nom': 'Rex', 'type': 'Chien'},
    {'nom': 'Mimi', 'type': 'Chat'},
  ];

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  void _ajouterAnimal() {
    _nomController.clear();
    _typeController.clear();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Ajouter un Animal"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: "Nom de l'animal"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: "Type d'animal"),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                if (_nomController.text.isNotEmpty && _typeController.text.isNotEmpty) {
                  setState(() {
                    _animaux.add({
                      'nom': _nomController.text,
                      'type': _typeController.text,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Ajouter"))
        ],
      ),
    );
  }

  void _modifierAnimal(int index) {
    _nomController.text = _animaux[index]['nom']!;
    _typeController.text = _animaux[index]['type']!;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Modifier l'animal"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: "Nom de l'animal"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: "Type d'animal"),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                if (_nomController.text.isNotEmpty && _typeController.text.isNotEmpty) {
                  setState(() {
                    _animaux[index] = {
                      'nom': _nomController.text,
                      'type': _typeController.text,
                    };
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Modifier"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mes Animaux")),
      body: ListView.builder(
        itemCount: _animaux.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_animaux[index]['nom']!),
            subtitle: Text("Type : ${_animaux[index]['type']}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _modifierAnimal(index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => setState(() => _animaux.removeAt(index)),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _ajouterAnimal,
        child: const Icon(Icons.add),
      ),
    );
  }
}

