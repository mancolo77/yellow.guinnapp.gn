import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TournamentsTab extends StatelessWidget {
  const TournamentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Ma sélection', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
          const SizedBox(height: 8),
          const Text('Rencontres et clubs favoris enregistrés', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
          const SizedBox(height: 16),
          Card(
            color: AppTheme.surfaceCard,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: const ListTile(
              leading: Icon(Icons.star_rounded, color: AppTheme.primary, size: 28),
              title: Text('Horoya AC vs Hafia FC', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMain)),
              subtitle: Text('Score: 2 : 1 • Stade du 28 Septembre', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}
