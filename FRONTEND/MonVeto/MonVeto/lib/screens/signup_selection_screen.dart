import 'package:flutter/material.dart';
import 'signup_vet_screen.dart'; // Assurez-vous que les bonnes pages sont importées
import 'signup_patient_screen.dart';

class SignupSelectionScreen extends StatelessWidget {
  const SignupSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text('Choisir un type de compte', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Inscrivez-vous en tant que :',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildOptionButton(
              context,
              title: 'Vétérinaire',
              icon: Icons.medical_services,
              color: Colors.green.shade600,
              onTap: () => _navigateToSignupVet(context),
            ),
            const SizedBox(height: 24),
            _buildOptionButton(
              context,
              title: 'Propriétaire d\'animal',
              icon: Icons.pets,
              color: Colors.green.shade400,
              onTap: () => _navigateToSignupPatient(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 26),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
    );
  }

  // Fonction pour rediriger vers la page d'inscription vétérinaire avec MaterialPageRoute
  void _navigateToSignupVet(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SignupVetScreen()),
    );
  }

  // Fonction pour rediriger vers la page d'inscription propriétaire d'animal avec MaterialPageRoute
  void _navigateToSignupPatient(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SignupPatientScreen()),
    );
  }
}
