import 'package:flutter/material.dart';
import 'package:monveto/screens/AnimalListPage.dart';
import 'package:monveto/screens/AnimalTypePage.dart';
import 'package:monveto/screens/AppointmentPage.dart';
import 'package:monveto/screens/ChatScreen.dart';
import 'package:monveto/screens/HomePageAnim.dart';
import 'package:monveto/screens/NotificationsScreen.dart';
import 'package:monveto/screens/ProfilePage.dart';

class DashboardPatientScreen extends StatefulWidget {
  const DashboardPatientScreen({super.key});

  @override
  _DashboardPatientScreenState createState() => _DashboardPatientScreenState();
}

class _DashboardPatientScreenState extends State<DashboardPatientScreen> {
  int _currentIndex = 0; // Indice de la page actuelle

  final List<Widget> _pages = [
    const HomePage(),
       AnimalListPage(),
    const AnimalTypePage(),
    const AppointmentPage(),  // Ajoutez la page des rendez-vous
    const ProfilePage(),
  ]; // Liste des pages à afficher en fonction de l'indice

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getPageTitle(),  // Dynamisez le titre en fonction de la page
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () {
              // Naviguer vers la page de chat
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Naviguer vers la page de notifications
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsScreen()),
              );
            },
          ),
        ],
      ),
      body: _pages[_currentIndex], // Affiche la page correspondante en fonction de l'indice
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Change la page affichée en fonction de l'onglet sélectionné
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Animaux',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Types d\'animaux',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Rendez-vous',  // Nouvelle entrée pour les rendez-vous
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
        ],
        selectedItemColor: Colors.blue.shade700,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  // Fonction pour obtenir le titre dynamique de l'AppBar en fonction de la page sélectionnée
  String _getPageTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Accueil';
      case 1:
        return 'Animaux';
      case 2:
        return 'Types d\'animaux';
      case 3:
        return 'Rendez-vous';
      case 4:
        return 'Profil';
      default:
        return 'Dashboard';
    }
  }
}
