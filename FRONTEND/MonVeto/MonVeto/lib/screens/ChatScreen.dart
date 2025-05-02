import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key}); // Retirer le 'const' ici

  // Liste des fausses conversations
  final List<Map<String, String>> conversations = [
    {'name': 'Dr. Martin', 'lastMessage': 'Bonjour, comment allez-vous?', 'time': '10:30'},
    {'name': 'Dr. Dupont', 'lastMessage': 'Votre animal va très bien!', 'time': '09:45'},
    {'name': 'Dr. Lefevre', 'lastMessage': 'Rendez-vous confirmé pour demain.', 'time': '08:00'},
  ];

  // Liste des fausses messages dans une conversation
  final List<Map<String, String>> messages = [
    {'sender': 'Vous', 'message': 'Bonjour, j\'ai une question sur la santé de mon chien.'},
    {'sender': 'Dr. Martin', 'message': 'Bonjour, quel est le problème avec votre chien?'},
    {'sender': 'Vous', 'message': 'Il a de la fièvre et il ne mange pas.'},
    {'sender': 'Dr. Martin', 'message': 'D\'accord, je vous recommande de prendre un rendez-vous.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Naviguer vers la page des notifications
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          return ListTile(
            leading: const Icon(Icons.person), // Remplacer par un icône d'avatar
            title: Text(conversation['name']!),
            subtitle: Text(conversation['lastMessage']!),
            trailing: Text(conversation['time']!),
            onTap: () {
              // Ouvrir la conversation
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConversationScreen(messages: messages),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ConversationScreen extends StatelessWidget {
  final List<Map<String, String>> messages;

  ConversationScreen({super.key, required this.messages}); // Retirer le 'const' ici

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dr. Martin'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isSender = message['sender'] == 'Vous';
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSender ? Colors.blueAccent : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        message['message']!,
                        style: TextStyle(color: isSender ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Tapez un message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Envoyer un message
                    // Ajouter la logique pour envoyer un message
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
