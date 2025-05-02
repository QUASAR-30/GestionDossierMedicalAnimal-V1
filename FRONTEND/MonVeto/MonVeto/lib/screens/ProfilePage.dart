import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController(text: 'Mme Dupont');
  final TextEditingController _emailController = TextEditingController(text: 'madame@dupont.com');
  final TextEditingController _phoneController = TextEditingController(text: '123-456-789');
  final TextEditingController _addressController = TextEditingController(text: '123 Rue , Douala');
  final TextEditingController _dobController = TextEditingController(text: '01/01/1985');

  bool _isEditing = false;

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    // Logic for saving the modified profile data (could be stored locally or sent to a server)
    _toggleEditing();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil mis à jour !')));
  }

  void _deleteProfile() {
    // Logic for deleting profile data (simulate with clearing fields)
    setState(() {
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _addressController.clear();
      _dobController.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil supprimé !')));
  }

  @override
  Widget build(BuildContext context) {
    final Color menuBlueColor = Colors.blue.shade700; // Color used in the menu

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: menuBlueColor,
                child: const Icon(Icons.person, size: 70, color: Colors.white),
              ),
              const SizedBox(height: 20),
              _isEditing
                  ? TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              )
                  : Text(
                _nameController.text,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _isEditing
                  ? TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              )
                  : Text(_emailController.text, style: const TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 12),
              _isEditing
                  ? TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Téléphone',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              )
                  : Text(_phoneController.text, style: const TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 12),
              _isEditing
                  ? TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Adresse',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              )
                  : Text(_addressController.text, style: const TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 12),
              _isEditing
                  ? TextField(
                controller: _dobController,
                decoration: const InputDecoration(
                  labelText: 'Date de naissance',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              )
                  : Text(_dobController.text, style: const TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 20),
              _isEditing
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(backgroundColor: menuBlueColor),
                    child: const Text('Enregistrer'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _toggleEditing,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: const Text('Annuler'),
                  ),
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _toggleEditing,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    child: const Text('Modifier'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _deleteProfile,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Supprimer'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
