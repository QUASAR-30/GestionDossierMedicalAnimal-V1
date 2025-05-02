import 'package:flutter/material.dart';
import 'package:monveto/models/Animal.dart';
import 'package:monveto/services/Animalservice.dart';
import 'package:intl/intl.dart';

class DossierMedicalPage extends StatefulWidget {
  final Animal animal;

  const DossierMedicalPage({Key? key, required this.animal}) : super(key: key);

  @override
  State<DossierMedicalPage> createState() => _DossierMedicalPageState();
}

class _DossierMedicalPageState extends State<DossierMedicalPage> with SingleTickerProviderStateMixin {
  final Animalservice _animalService = Animalservice();
  bool isLoading = true;
  Map<String, dynamic> animalDetails = {};
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadDossierMedical();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadDossierMedical() async {
    try {
      setState(() => isLoading = true);
      final details = await _animalService.getAnimalDetails(widget.animal.idAnimal);
      setState(() {
        animalDetails = details;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      _showErrorSnackbar('Erreur de chargement: $e');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Non défini';
    try {
      final DateTime date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  Widget _buildDossierInfo() {
    final dossier = animalDetails['dossierDTO'];
    if (dossier == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Aucun dossier médical disponible pour cet animal.'),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Informations du dossier',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('ID du dossier: ${dossier['idDossier'] ?? 'Non défini'}'),
                  Text('Date de création: ${_formatDate(dossier['dateCreation'])}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsultationsTab() {
    final dossier = animalDetails['dossierDTO'];
    if (dossier == null) {
      return const Center(child: Text('Aucun dossier médical disponible'));
    }

    final consultations = dossier['consultations'] as List<dynamic>? ?? [];
    
    if (consultations.isEmpty) {
      return const Center(child: Text('Aucune consultation enregistrée'));
    }

    return ListView.builder(
      itemCount: consultations.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final consultation = consultations[index];
        final traitements = consultation['traitements'] as List<dynamic>? ?? [];
        
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: ExpansionTile(
            title: Text(
              'Consultation du ${_formatDate(consultation['dateConsultation'])}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Symptômes: ${consultation['syntome'] ?? 'Non spécifié'}'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Diagnostic: ${consultation['diagnostic'] ?? 'Non spécifié'}'),
                    const SizedBox(height: 16),
                    
                    if (traitements.isNotEmpty) ...[
                      const Text(
                        'Traitements prescrits:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ...traitements.map((traitement) => Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                traitement['contenuTraitement'] ?? 'Description non disponible',
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Période: ${_formatDate(traitement['dateDebut'])} - ${_formatDate(traitement['dateFin'])}',
                                style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                              ),
                              Text(
                                'Fréquence: ${traitement['frequence'] ?? 'Non spécifiée'}',
                                style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      )).toList(),
                    ] else
                      const Text('Aucun traitement prescrit'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMaladiesTab() {
    final dossier = animalDetails['dossierDTO'];
    if (dossier == null) {
      return const Center(child: Text('Aucun dossier médical disponible'));
    }

    final maladies = dossier['maladies'] as List<dynamic>? ?? [];
    
    if (maladies.isEmpty) {
      return const Center(child: Text('Aucune maladie enregistrée'));
    }

    return ListView.builder(
      itemCount: maladies.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final maladie = maladies[index];
        
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: ListTile(
            title: Text(
              maladie['nomMaladie'] ?? 'Maladie non spécifiée',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Diagnostiqué le: ${_formatDate(maladie['dateDiagnostic'])}'),
                if (maladie['commentaire'] != null && maladie['commentaire'].isNotEmpty)
                  Text('Commentaire: ${maladie['commentaire']}'),
              ],
            ),
            isThreeLine: maladie['commentaire'] != null && maladie['commentaire'].isNotEmpty,
          ),
        );
      },
    );
  }

  Widget _buildVaccinsTab() {
    final dossier = animalDetails['dossierDTO'];
    if (dossier == null) {
      return const Center(child: Text('Aucun dossier médical disponible'));
    }

    final vaccins = dossier['vaccins'] as List<dynamic>? ?? [];
    
    if (vaccins.isEmpty) {
      return const Center(child: Text('Aucun vaccin enregistré'));
    }

    return ListView.builder(
      itemCount: vaccins.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final vaccin = vaccins[index];
        final bool hasRappel = vaccin['dateRappel'] != null;
        final bool isLate = hasRappel && 
                            DateTime.parse(vaccin['dateRappel']).isBefore(DateTime.now());
        
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: ListTile(
            title: Text(
              vaccin['typeVaccin'] ?? 'Vaccin non spécifié',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Administré le: ${_formatDate(vaccin['dateVaccin'])}'),
                if (hasRappel)
                  Text(
                    'Rappel prévu le: ${_formatDate(vaccin['dateRappel'])}',
                    style: TextStyle(
                      color: isLate ? Colors.red : Colors.green,
                      fontWeight: isLate ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                Text('Statut: ${vaccin['statut'] ?? 'Non défini'}'),
              ],
            ),
            isThreeLine: true,
            leading: CircleAvatar(
              backgroundColor: hasRappel 
                  ? (isLate ? Colors.red.shade100 : Colors.green.shade100)
                  : Colors.blue.shade100,
              child: Icon(
                Icons.vaccines,
                color: hasRappel 
                    ? (isLate ? Colors.red : Colors.green)
                    : Colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dossier médical - ${widget.animal.nomAnimal}'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Dossier', icon: Icon(Icons.folder)),
            Tab(text: 'Consultations', icon: Icon(Icons.medical_services)),
            Tab(text: 'Maladies', icon: Icon(Icons.sick)),
            Tab(text: 'Vaccins', icon: Icon(Icons.vaccines)),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildDossierInfo(),
                _buildConsultationsTab(),
                _buildMaladiesTab(),
                _buildVaccinsTab(),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Ajouter une nouvelle consultation/vaccin/maladie selon l'onglet actif
          _showErrorSnackbar('Fonctionnalité non implémentée');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}