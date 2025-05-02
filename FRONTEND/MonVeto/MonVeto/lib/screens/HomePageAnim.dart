import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Section de statistiques
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCard(
                    context,
                    title: 'Nombre d\'animaux',
                    value: '5',
                    icon: Icons.pets,
                  ),
                  _buildCard(
                    context,
                    title: 'Types d\'animaux',
                    value: '3',
                    icon: Icons.category,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCard(
                    context,
                    title: 'Rendez-vous',
                    value: '2',
                    icon: Icons.calendar_today,
                  ),
                  _buildCard(
                    context,
                    title: 'Messages',
                    value: '4',
                    icon: Icons.chat,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Liste des dernières notifications/messages
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dernières notifications',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildNotificationItem(
                        context, 'Rendez-vous chez le vétérinaire demain.'),
                    _buildNotificationItem(
                        context, 'Nouveau message de vétérinaire.'),
                    _buildNotificationItem(context, 'Vaccination de l\'animal prévue.'),
                    _buildNotificationItem(context, 'Consultation planifiée.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fonction pour construire une carte de statistique
  Widget _buildCard(BuildContext context,
      {required String title, required String value, required IconData icon}) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 24, // Responsif: 50% de la largeur
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.blue.shade700),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Fonction pour afficher une notification
  Widget _buildNotificationItem(BuildContext context, String notification) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        notification,
        style: const TextStyle(fontSize: 16, color: Colors.black54),
      ),
    );
  }
}
