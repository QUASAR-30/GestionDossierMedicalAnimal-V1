import 'package:flutter/material.dart';
import 'package:monveto/models/Veterinaire.dart';
import 'package:monveto/services/veterinaireService.dart';
import 'login_screen.dart'; // Redirection vers la page de connexion

class SignupVetScreen extends StatefulWidget {
  const SignupVetScreen({super.key});

  @override
  _SignupVetScreenState createState() => _SignupVetScreenState();
}

class _SignupVetScreenState extends State<SignupVetScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false; 

Future<void> onSave() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try{
        await VeterinaireService().save(
            Veterinaire(
                nom_veterinaire: nameController.text,
                email_veterinaire: emailController.text,
                mdp_veterinaire: passwordController.text,
                numero_veterinaire: phoneController.text,
            )
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Veterinaire enregistré avec success")),
        );
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text('Inscription Vétérinaire', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: ConstrainedBox(
              key: _formKey,
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const Text(
                      'Créer un compte Vétérinaire',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    _buildInputField(controller: nameController, label: 'Nom complet', icon: Icons.person),
                    const SizedBox(height: 16),
                    _buildInputField(controller: emailController, label: 'Email', icon: Icons.email),
                    const SizedBox(height: 16),
                    _buildInputField(controller: passwordController, label: 'Mot de passe', icon: Icons.lock, obscureText: true),
                    const SizedBox(height: 16),
                    _buildInputField(controller: phoneController, label: 'Numéro de téléphone', icon: Icons.phone),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _registerVet, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white) 
                            : const Text(
                          "S'inscrire",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        // Redirection vers la page de connexion
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        "Déjà un compte ? Connectez-vous ici",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      ),
    );
  }

  
  Future<void> _registerVet() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 3)); 
// redirection
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }
}
