import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildNotificationCard(
              context, // Pass the context to the _buildNotificationCard method
              title: "Nouveau Rendez-vous",
              description: "Un nouveau rendez-vous a été ajouté par le propriétaire.",
              date: "Aujourd'hui, 14:30",
              onTap: () {
                // Rediriger vers la page des rendez-vous
                Navigator.pushNamed(context, '/appointments'); // Navigation utilisant le context
              },
            ),
            const SizedBox(height: 16),
            _buildNotificationCard(
              context, // Pass the context to the _buildNotificationCard method
              title: "Nouveau Message",
              description: "Le propriétaire vous a envoyé un message.",
              date: "Hier, 18:15",
              onTap: () {
                // Rediriger vers la page de chat
                Navigator.pushNamed(context, '/chat'); // Navigation utilisant le context
              },
            ),
            const SizedBox(height: 16),
            _buildNotificationCard(
              context, // Pass the context to the _buildNotificationCard method
              title: "Rappel de vaccination",
              description: "Le vaccin de l'animal est dû dans 2 jours.",
              date: "Demain, 09:00",
              onTap: () {
                // Rediriger vers la page de vaccination
                Navigator.pushNamed(context, '/vaccination');
              },
            ),
            const SizedBox(height: 16),
            _buildNotificationCard(
              context, // Pass the context to the _buildNotificationCard method
              title: "Suivi de santé animal",
              description: "Le vétérinaire recommande un suivi pour l'animal.",
              date: "Il y a 3 jours, 16:00",
              onTap: () {
                // Rediriger vers la page de santé animale
                Navigator.pushNamed(context, '/animal_health');
              },
            ),
            // Ajouter d'autres notifications si nécessaire
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
      BuildContext context, {
        required String title,
        required String description,
        required String date,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.notifications, size: 30, color: Colors.green.shade700),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(description, style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 8),
                    Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Logique pour supprimer la notification (par exemple, en utilisant un setState si c'est dynamique)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notification supprimée')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
