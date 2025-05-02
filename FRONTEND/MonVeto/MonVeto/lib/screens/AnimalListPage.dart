import 'package:flutter/material.dart';
import 'package:monveto/models/Animal.dart';
import 'package:monveto/services/Animalservice.dart';
import 'package:monveto/screens/DossierMedicalPage.dart';


class AnimalListPage extends StatefulWidget {
  const AnimalListPage({super.key});

  @override
  State<AnimalListPage> createState() => _AnimalListPageState();
}

class _AnimalListPageState extends State<AnimalListPage> {
  final Animalservice _animalService = Animalservice();
  List<Animal> animals = [];
  bool isLoading = true;
  bool isProcessing = false;

  // Données pour les dropdowns
  List<Map<String, dynamic>> _especes = [];
  List<Map<String, dynamic>> _proprietaires = [];
  List<Map<String, dynamic>> _veterinaires = [];

  // Contrôleurs pour le formulaire
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _sexeController = TextEditingController();
  final TextEditingController _couleurController = TextEditingController();
  
  // Valeurs sélectionnées
  String? _selectedEspeceId;
  String? _selectedProprietaireId;
  String? _selectedVeterinaireId;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      setState(() => isLoading = true);
      await Future.wait([
        _loadAnimals(),
        _loadEspeces(),
        _loadProprietaires(),
        _loadVeterinaires(),
      ]);
    } catch (e) {
      _showErrorSnackbar('Erreur d\'initialisation: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    // Disposez tous les contrôleurs
    _nomController.dispose();
    _ageController.dispose();
    _sexeController.dispose();
    _couleurController.dispose();
    super.dispose();
  }

  Future<void> _loadAnimals() async {
    try {
      final animalList = await _animalService.getAnimals();
      setState(() => animals = animalList);
    } catch (e) {
      _showErrorSnackbar('Erreur lors du chargement des animaux: $e');
    }
  }

  Future<void> _loadEspeces() async {
    try {
      final especes = await _animalService.getEspeces();
      setState(() => _especes = especes);
    } catch (e) {
      _showErrorSnackbar('Erreur lors du chargement des espèces: $e');
    }
  }

  Future<void> _loadProprietaires() async {
    try {
      final proprietaires = await _animalService.getProprietaires();
      setState(() => _proprietaires = proprietaires);
    } catch (e) {
      _showErrorSnackbar('Erreur lors du chargement des propriétaires: $e');
    }
  }

  Future<void> _loadVeterinaires() async {
    try {
      final veterinaires = await _animalService.getVeterinaires();
      setState(() => _veterinaires = veterinaires);
    } catch (e) {
      _showErrorSnackbar('Erreur lors du chargement des vétérinaires: $e');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _addAnimal() {
    _clearFormSelections();
    _showAnimalDialog(
      title: 'Ajouter un Animal',
      buttonText: 'Ajouter',
      onSubmit: _handleAddAnimal,
    );
  }

  void _editAnimal(Animal animal) {
    _populateForm(animal);
    _showAnimalDialog(
      title: 'Modifier Animal',
      buttonText: 'Modifier',
      onSubmit: () => _handleUpdateAnimal(animal.idAnimal),
    );
  }

  Future<void> _handleAddAnimal() async {
    if (!_validateFields()) return;

    setState(() => isProcessing = true);
    try {
      await _animalService.saveOrUpdateAnimal(_createAnimalFromFields());
      await _loadAnimals();
      if (mounted) Navigator.pop(context);
      _showSuccessSnackbar('Animal ajouté avec succès!');
    } catch (e) {
      _showErrorSnackbar("Erreur lors de l'ajout: $e");
    } finally {
      setState(() => isProcessing = false);
    }
  }

  Future<void> _handleUpdateAnimal(String id) async {
    if (!_validateFields()) return;

    setState(() => isProcessing = true);
    try {
      Animal updatedAnimal = _createAnimalFromFields();
      updatedAnimal.idAnimal = id;
      await _animalService.saveOrUpdateAnimal(updatedAnimal);
      await _loadAnimals();
      if (mounted) Navigator.pop(context);
      _showSuccessSnackbar('Animal modifié avec succès!');
    } catch (e) {
      _showErrorSnackbar("Erreur lors de la modification: $e");
    } finally {
      setState(() => isProcessing = false);
    }
  }

  Future<void> _deleteAnimal(Animal animal) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: Text('Supprimer ${animal.nomAnimal}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _animalService.deleteAnimal(animal.idAnimal);
        await _loadAnimals();
        _showSuccessSnackbar('Animal supprimé avec succès!');
      } catch (e) {
        _showErrorSnackbar("Erreur lors de la suppression: $e");
      }
    }
  }

  void _showAnimalDialog({
    required String title,
    required String buttonText,
    required VoidCallback onSubmit,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: _buildAnimalForm(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: isProcessing ? null : onSubmit,
            child: isProcessing 
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(buttonText),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimalForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTextField(_nomController, 'Nom de l\'animal', true),
        _buildTextField(_ageController, 'Âge de l\'animal', true),
        _buildTextField(_sexeController, 'Sexe de l\'animal', true),
        _buildTextField(_couleurController, 'Couleur de l\'animal', true),
        
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 8),
        
        _buildDropdownField(
          'Espèce *',
          _especes,
          _selectedEspeceId,
          (value) => setState(() => _selectedEspeceId = value),
          'id',
          'nomEspece',
        ),
        
        const SizedBox(height: 16),
        _buildDropdownField(
          'Propriétaire *',
          _proprietaires,
          _selectedProprietaireId,
          (value) => setState(() => _selectedProprietaireId = value),
          'id',
          'nomProprietaire',
        ),
        
        const SizedBox(height: 16),
        _buildDropdownField(
          'Vétérinaire (Optionnel)',
          _veterinaires,
          _selectedVeterinaireId,
          (value) => setState(() => _selectedVeterinaireId = value),
          'id',
          'nomVeterinaire',
          isRequired: false,
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    bool isRequired,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: isRequired ? '$label *' : label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    List<Map<String, dynamic>> items,
    String? selectedValue,
    Function(String?) onChanged,
    String valueKey,
    String displayKey, {
    bool isRequired = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isRequired ? '$label *' : label,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              isExpanded: true,
              hint: const Text('  Sélectionnez...'),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              items: [
                if (!isRequired)
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('Aucun'),
                  ),
                ...items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item[valueKey],
                    child: Text(item[displayKey]),
                  );
                }).toList(),
              ],
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  bool _validateFields() {
    if (_nomController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _sexeController.text.isEmpty ||
        _couleurController.text.isEmpty ||
        _selectedEspeceId == null ||
        _selectedProprietaireId == null) {
      _showErrorSnackbar("Veuillez remplir tous les champs obligatoires");
      return false;
    }
    return true;
  }

  void _clearFormSelections() {
    _nomController.clear();
    _ageController.clear();
    _sexeController.clear();
    _couleurController.clear();
    setState(() {
      _selectedEspeceId = null;
      _selectedProprietaireId = null;
      _selectedVeterinaireId = null;
    });
  }

  void _populateForm(Animal animal) {
    _nomController.text = animal.nomAnimal;
    _ageController.text = animal.ageAnimal;
    _sexeController.text = animal.sexeAnimal;
    _couleurController.text = animal.couleurAnimal;
    setState(() {
      _selectedEspeceId = animal.especeId;
      _selectedProprietaireId = animal.proprietaireId;
      _selectedVeterinaireId = animal.veterinaireId;
    });
  }

  Animal _createAnimalFromFields() {
    String especeNom = '';
    String proprietaireNom = '';
    String? veterinaireNom;

    // Récupérer les noms correspondants aux IDs sélectionnés
    for (var espece in _especes) {
      if (espece['id'] == _selectedEspeceId) {
        especeNom = espece['nomEspece'];
        break;
      }
    }

    for (var proprietaire in _proprietaires) {
      if (proprietaire['id'] == _selectedProprietaireId) {
        proprietaireNom = proprietaire['nomProprietaire'];
        break;
      }
    }

    if (_selectedVeterinaireId != null) {
      for (var veterinaire in _veterinaires) {
        if (veterinaire['id'] == _selectedVeterinaireId) {
          veterinaireNom = veterinaire['nomVeterinaire'];
          break;
        }
      }
    }

    return Animal(
      idAnimal: '',
      nomAnimal: _nomController.text,
      ageAnimal: _ageController.text,
      sexeAnimal: _sexeController.text,
      couleurAnimal: _couleurController.text,
      especeId: _selectedEspeceId!,
      especeNom: especeNom,
      proprietaireId: _selectedProprietaireId!,
      proprietaireNom: proprietaireNom,
      veterinaireId: _selectedVeterinaireId,
      veterinaireNom: veterinaireNom,
    );
  }

  Widget _buildAnimalDetails(Animal animal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Âge', animal.ageAnimal),
        _buildInfoRow('Sexe', animal.sexeAnimal),
        _buildInfoRow('Couleur', animal.couleurAnimal),
        _buildInfoRow('Espèce', animal.especeNom),
        const Divider(),
        const Text('Propriétaire:', style: TextStyle(fontWeight: FontWeight.bold)),
        _buildInfoRow('Nom', animal.proprietaireNom),
        if (animal.veterinaireNom != null) ...[
          const Divider(),
          const Text('Vétérinaire:', style: TextStyle(fontWeight: FontWeight.bold)),
          _buildInfoRow('Nom', animal.veterinaireNom!),
        ],
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text('$label:', style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Animaux'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _initializeData,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : animals.isEmpty
              ? const Center(child: Text('Aucun animal trouvé'))
              : ListView.builder(
                  itemCount: animals.length,
                  itemBuilder: (context, index) {
                    final animal = animals[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: ExpansionTile(
                        title: Text(
                          animal.nomAnimal,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${animal.especeNom} | Âge: ${animal.ageAnimal}',
                        ),
                        leading: const CircleAvatar(child: Icon(Icons.pets)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editAnimal(animal),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteAnimal(animal),
                            ),
                            IconButton(
                              icon: const Icon(Icons.medical_services, color: Colors.green),
                              onPressed: () => _viewDossierMedical(animal),
                            ),
                          ],
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: _buildAnimalDetails(animal),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAnimal,
        child: const Icon(Icons.add),
      ),
    );
  }
  
  void _viewDossierMedical(Animal animal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DossierMedicalPage(animal: animal),
      ),
    );
  }
}