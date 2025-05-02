import 'package:flutter/material.dart';

class HomeVetScreen extends StatelessWidget {
  const HomeVetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _dashboardCard(
                  context,
                  title: 'Maladies enregistrées',
                  value: '12',
                  icon: Icons.healing,
                  color: Colors.orange,
                ),
                _dashboardCard(
                  context,
                  title: 'Vaccins',
                  value: '7',
                  icon: Icons.vaccines,
                  color: Colors.blue,
                ),
                _dashboardCard(
                  context,
                  title: 'Consultations',
                  value: '23',
                  icon: Icons.monitor_heart,
                  color: Colors.purple,
                ),
                _dashboardCard(
                  context,
                  title: 'Rendez-vous à venir',
                  value: '5',
                  icon: Icons.schedule,
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Rendez-vous récents',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _appointmentList(),
          ],
        ),
      ),

    );
  }

  Widget _dashboardCard(BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = width > 600 ? (width / 2 - 48) : width;
    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16)),
              Text(
                value,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _appointmentList() {
    final appointments = [
      {'date': '2025-04-20 10:00', 'client': 'Alice Dupont', 'animal': 'Chien'},
      {'date': '2025-04-21 14:00', 'client': 'Jean Martin', 'animal': 'Chat'},
      {'date': '2025-04-22 09:30', 'client': 'Lucie Lefevre', 'animal': 'Lapin'},
      {'date': '2025-04-23 11:00', 'client': 'Pierre Durand', 'animal': 'Chien'},
      {'date': '2025-04-24 15:00', 'client': 'Marie Bernier', 'animal': 'Chat'},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.pets, color: Colors.green),
            title: Text('${appointment['client']} - ${appointment['animal']}'),
            subtitle: Text(appointment['date']!),
          ),
        );
      },
    );
  }
}
