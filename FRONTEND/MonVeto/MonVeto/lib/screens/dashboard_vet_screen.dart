import 'package:flutter/material.dart';
import 'package:monveto/screens/ChatScreen.dart';
import 'home_vet_screen.dart';
import 'maladies_screen.dart';
import 'vaccins_screen.dart';
import 'consultations_screen.dart';
import 'rendezvous_screen.dart';
import 'profil_screen.dart';
import 'notifications_screen.dart';

class DashboardVetScreen extends StatefulWidget {
  const DashboardVetScreen({super.key});

  @override
  State<DashboardVetScreen> createState() => _DashboardVetScreenState();
}

class _DashboardVetScreenState extends State<DashboardVetScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeVetScreen(),
    MaladiesScreen(),
    VaccinsScreen(),
    ConsultationsScreen(),
    RendezVousScreen(),
    ProfilScreen(),
  ];

  final List<String> _titles = [
    'Accueil',
    'Maladies',
    'Vaccins',
    'Consultations',
    'Rendez-vous',
    'Profil',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return BottomNavigationBarItem(
      icon: isSelected
          ? Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green.shade100,
        ),
        child: Icon(icon, color: Colors.green),
      )
          : Icon(icon),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),  // Le titre change en fonction de l'élément sélectionné
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildNavItem(Icons.home, 'Accueil', 0),
          _buildNavItem(Icons.coronavirus, 'Maladies', 1),
          _buildNavItem(Icons.vaccines, 'Vaccins', 2),
          _buildNavItem(Icons.medical_services, 'Consultation', 3),
          _buildNavItem(Icons.calendar_month, 'RDV', 4),
          _buildNavItem(Icons.person, 'Profil', 5),
        ],
      ),
    );
  }
}
