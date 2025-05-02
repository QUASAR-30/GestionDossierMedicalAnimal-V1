// 📁 lib/screens/consultations_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsultationsScreen extends StatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  _ConsultationsScreenState createState() => _ConsultationsScreenState();
}

class _ConsultationsScreenState extends State<ConsultationsScreen> {
  final List<Map<String, String>> consultations = [
    {'date': '2025-04-20', 'client': 'Alice Dupont', 'animal': 'Chien', 'details': 'Consultation générale'},
    {'date': '2025-04-21', 'client': 'Jean Martin', 'animal': 'Chat', 'details': 'Vérification de santé'},
  ];

  void _openConsultationDialog({Map<String, String>? consultation}) {
    final TextEditingController clientController = TextEditingController(text: consultation?['client'] ?? '');
    final TextEditingController animalController = TextEditingController(text: consultation?['animal'] ?? '');
    final TextEditingController detailsController = TextEditingController(text: consultation?['details'] ?? '');
    DateTime? selectedDate = consultation != null ? DateTime.parse(consultation['date']!) : null;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(consultation == null ? 'Ajouter Consultation' : 'Modifier Consultation'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: clientController,
                  decoration: const InputDecoration(labelText: 'Client'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: animalController,
                  decoration: const InputDecoration(labelText: 'Animal'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: detailsController,
                  decoration: const InputDecoration(labelText: 'Détails'),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != selectedDate)
                      setState(() {
                        selectedDate = picked;
                      });
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(labelText: 'Date de consultation'),
                    child: Text(
                      selectedDate == null
                          ? 'Sélectionner la date'
                          : DateFormat('yyyy-MM-dd').format(selectedDate!),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                if (clientController.text.isEmpty ||
                    animalController.text.isEmpty ||
                    detailsController.text.isEmpty ||
                    selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez remplir tous les champs')),
                  );
                  return;
                }

                if (consultation == null) {
                  setState(() {
                    consultations.add({
                      'date': DateFormat('yyyy-MM-dd').format(selectedDate!),
                      'client': clientController.text,
                      'animal': animalController.text,
                      'details': detailsController.text,
                    });
                  });
                } else {
                  setState(() {
                    consultation['client'] = clientController.text;
                    consultation['animal'] = animalController.text;
                    consultation['details'] = detailsController.text;
                    consultation['date'] = DateFormat('yyyy-MM-dd').format(selectedDate!);
                  });
                }

                Navigator.pop(context);
              },
              child: Text(consultation == null ? 'Ajouter' : 'Modifier'),
            ),
          ],
        );
      },
    );
  }

  void _deleteConsultation(Map<String, String> consultation) {
    setState(() {
      consultations.remove(consultation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: consultations.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 5,
                    child: ListTile(
                      title: Text(consultations[index]['client']!),
                      subtitle: Text('${consultations[index]['animal']} - ${consultations[index]['details']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _openConsultationDialog(consultation: consultations[index]),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteConsultation(consultations[index]),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openConsultationDialog(),
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
