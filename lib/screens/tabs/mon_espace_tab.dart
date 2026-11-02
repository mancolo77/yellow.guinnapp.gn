import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/journees_service.dart';

class MonEspaceTab extends StatefulWidget {
  const MonEspaceTab({super.key});

  @override
  State<MonEspaceTab> createState() => _MonEspaceTabState();
}

class _MonEspaceTabState extends State<MonEspaceTab> {
  final JourneesService _service = JourneesService();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _service.userName);
    _service.addListener(_onServiceUpdate);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _service.removeListener(_onServiceUpdate);
    super.dispose();
  }

  void _onServiceUpdate() {
    if (mounted) setState(() {});
  }

  void _save() {
    _service.updateProfile(_nameController.text.trim(), _service.favTeam);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Espace mis à jour')));
  }

  @override
  Widget build(BuildContext context) {
    final count = _service.favMatchIds.length;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.darkNav,
        elevation: 0,
        title: const Text('Mon Espace', style: TextStyle(color: AppTheme.textMain, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: AppTheme.surfaceCard,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.cardRadius)),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: AppTheme.primary,
                      child: Icon(Icons.sports_soccer_rounded, color: AppTheme.buttonTextDark, size: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_service.userName, style: const TextStyle(color: AppTheme.textMain, fontWeight: FontWeight.bold, fontSize: 17)),
                          const SizedBox(height: 4),
                          Text('Club favori : ${_service.favTeam}', style: const TextStyle(color: AppTheme.primary, fontSize: 13, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 2),
                          Text('$count match(s) sélectionné(s)', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Préférences du profil', style: TextStyle(color: AppTheme.textMain, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Votre nom ou pseudonyme',
                labelStyle: const TextStyle(color: AppTheme.textSecondary),
                filled: true,
                fillColor: AppTheme.surfaceCard,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppTheme.buttonRadius), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(color: AppTheme.surfaceCard, borderRadius: BorderRadius.circular(AppTheme.buttonRadius)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _service.favTeam,
                  dropdownColor: AppTheme.surfaceCard,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: AppTheme.primary),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  onChanged: (val) {
                    if (val != null) {
                      _service.updateProfile(_nameController.text.trim(), val);
                    }
                  },
                  items: _service.teams.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: AppTheme.buttonHeight,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: AppTheme.buttonTextDark,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.buttonRadius)),
                ),
                child: const Text('Enregistrer mon espace', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ),
            const SizedBox(height: 28),

            OutlinedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: AppTheme.surfaceCard,
                    title: const Text('Réinitialiser les données ?', style: TextStyle(color: Colors.white)),
                    content: const Text('Confirmez-vous la réinitialisation de votre sélection et de vos paramètres ?', style: TextStyle(color: AppTheme.textSecondary)),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Annuler', style: TextStyle(color: AppTheme.textSecondary))),
                      TextButton(
                        onPressed: () {
                          _service.resetData();
                          _nameController.text = _service.userName;
                          Navigator.pop(ctx);
                        },
                        child: const Text('Réinitialiser', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 44),
                side: const BorderSide(color: AppTheme.border),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.buttonRadius)),
              ),
              child: const Text('Réinitialiser toutes les données', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }
}

