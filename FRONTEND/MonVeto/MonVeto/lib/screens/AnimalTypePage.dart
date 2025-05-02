import 'package:flutter/material.dart';
import 'package:monveto/models/Espece.dart';
import 'package:monveto/services/EspeceService.dart';

class AnimalTypePage extends StatefulWidget {
  const AnimalTypePage({super.key});

  @override
  State<AnimalTypePage> createState() => _AnimalTypePageState();
}

class _AnimalTypePageState extends State<AnimalTypePage> {
  final EspeceService _especeService = EspeceService();
  final TextEditingController _typeController = TextEditingController();
  late Future<List<Espece>> _especesFuture;

  @override
  void initState() {
    super.initState();
    _refreshEspeces();
  }

  void _refreshEspeces() {
    setState(() {
      _especesFuture = _especeService.get();
    });
  }

  void _editTypeDialog(Espece espece) {
    _typeController.text = espece.type;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier le Type'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: TextField(
          controller: _typeController,
          decoration: const InputDecoration(
            labelText: 'Nom du Type d\'animal',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _typeController.clear();
            },
            child: const Text('Annuler', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () async {
              final nom = _typeController.text.trim();
              if (nom.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Le champ ne peut pas être vide!")),
                );
                return;
              }

              try {
                await _especeService.update(
                  espece.id_espece!,
                  Espece(type: nom, id_espece: espece.id_espece),
                );
                Navigator.pop(context);
                _typeController.clear();
                _refreshEspeces();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Erreur : ${e.toString()}")),
                );
              }
            },
            child: const Text('Modifier', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  void _addTypeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un Type'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: TextField(
          controller: _typeController,
          decoration: const InputDecoration(
            labelText: 'Nom du Type d\'animal',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _typeController.clear();
            },
            child: const Text('Annuler', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () async {
              final nom = _typeController.text.trim();
              if (nom.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Le champ ne peut pas être vide!")),
                );
                return;
              }

              try {
                await _especeService.save(Espece(type: nom));
                Navigator.pop(context);
                _typeController.clear();
                _refreshEspeces();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Erreur : ${e.toString()}")),
                );
              }
            },
            child: const Text('Ajouter', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

 void _deleteType(String? idEspece) async {
  // Vérification de l'ID avant la suppression
  if (idEspece == null || idEspece.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("ID de l'espèce invalide")),
    );
    return;
  }

  // Ajout d'une confirmation avant la suppression
  bool? confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirmation'),
      content: const Text('Voulez-vous vraiment supprimer cette espèce ?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Annuler', style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );

  if (confirm != true) return;

  try {
    setState(() => _especesFuture = Future.value([])); // Indique le chargement
    await _especeService.delete(idEspece);
    _refreshEspeces(); // Actualise la liste
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Espèce supprimée avec succès")),
      );
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Espece>>(
        future: _especesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucun type d'animal trouvé"));
          }

          final especes = snapshot.data!;
          return ListView.builder(
            itemCount: especes.length,
            itemBuilder: (context, index) {
              final espece = especes[index];
              return ListTile(
                title: Text(espece.type),
                leading: const Icon(Icons.category),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editTypeDialog(espece),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        if (espece.id_espece != null) {
                          _deleteType(espece.id_espece);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("ID de l'espèce manquant")),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTypeDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}