import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  List<Map<String, String>> appointments = [
    {'date': '2025-05-01 10:00', 'vet': 'Dr. John', 'problem': 'Vérification annuelle'},
    {'date': '2025-05-02 14:00', 'vet': 'Dr. Claire', 'problem': 'Consultation de routine'},
    {'date': '2025-05-05 09:30', 'vet': 'Dr. Alice', 'problem': 'Problème de peau'},
  ];

  final TextEditingController _problemController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  String? _selectedVet;
  final List<String> _vets = ['Dr. John', 'Dr. Claire', 'Dr. Alice'];

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        _timeController.text = "${selectedTime.format(context)}";
      });
    }
  }

  void _addAppointment() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          title: const Text('Ajouter un Rendez-vous', textAlign: TextAlign.center),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _timeController,
                  decoration: const InputDecoration(
                    labelText: 'Heure',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () => _selectTime(context),
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: _selectedVet,
                  decoration: const InputDecoration(
                    labelText: 'Sélectionner le vétérinaire',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedVet = newValue;
                    });
                  },
                  items: _vets.map<DropdownMenuItem<String>>((String vet) {
                    return DropdownMenuItem<String>(
                      value: vet,
                      child: Text(vet),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _problemController,
                  decoration: const InputDecoration(
                    labelText: 'Problème/Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _problemController.clear();
                _dateController.clear();
                _timeController.clear();
                setState(() {
                  _selectedVet = null;
                });
              },
              child: const Text('Annuler', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                if (_dateController.text.isEmpty ||
                    _timeController.text.isEmpty ||
                    _selectedVet == null ||
                    _problemController.text.isEmpty) {
                  // Afficher un message d'erreur si un champ est vide
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Tous les champs doivent être remplis!")),
                  );
                  return; // Ne pas fermer la fenêtre si les champs sont vides
                }

                setState(() {
                  appointments.add({
                    'date': "${_dateController.text} ${_timeController.text}",
                    'vet': _selectedVet!,
                    'problem': _problemController.text,
                  });
                });
                Navigator.pop(context);
                _problemController.clear();
                _dateController.clear();
                _timeController.clear();
                setState(() {
                  _selectedVet = null;
                });
              },
              child: const Text('Ajouter', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  void _deleteAppointment(int index) {
    setState(() {
      appointments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${appointments[index]['date']}'),
            subtitle: Text('Vétérinaire: ${appointments[index]['vet']} \nProblème: ${appointments[index]['problem']}'),
            leading: const Icon(Icons.calendar_today),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteAppointment(index),
            ),
            onTap: () {
              // Action à effectuer lorsqu'on clique sur un rendez-vous
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAppointment,
        child: const Icon(Icons.add),
        backgroundColor: Colors.green.shade700,
      ),
    );
  }
}
