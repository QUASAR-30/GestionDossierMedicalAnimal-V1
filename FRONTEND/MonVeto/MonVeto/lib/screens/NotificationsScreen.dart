import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.blue.shade700, // Utiliser une couleur similaire à celle du menu
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Action de recherche si nécessaire
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            NotificationTile(
              title: 'Rendez-vous demain à 10h00 avec votre vétérinaire.',
              subtitle: 'N\'oubliez pas d\'apporter les documents nécessaires.',
            ),
            NotificationTile(
              title: 'Vaccination de votre animal prévue la semaine prochaine.',
              subtitle: 'Vérifiez les rappels de vaccination.',
            ),
            NotificationTile(
              title: 'Message du vétérinaire: Suivi de santé requis pour votre animal.',
              subtitle: 'Merci de confirmer votre prochain rendez-vous.',
            ),
            NotificationTile(
              title: 'Rappel: Dernier jour pour l\'enregistrement des nouveaux animaux.',
              subtitle: 'Ne manquez pas cette occasion pour inscrire votre animal.',
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Icon(
          Icons.notifications,
          color: Colors.blue.shade700,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // Logique pour supprimer la notification
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notification supprimée')),
            );
          },
        ),
      ),
    );
  }
}
