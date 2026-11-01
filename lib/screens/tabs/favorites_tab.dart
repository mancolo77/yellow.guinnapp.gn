import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Mon espace', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
          const SizedBox(height: 16),
          Card(
            color: AppTheme.surfaceCard,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(backgroundColor: AppTheme.primary, child: Icon(Icons.person, color: AppTheme.buttonTextDark)),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Supporter Guinéen', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.textMain)),
                      SizedBox(height: 4),
                      Text('Club favori: Horoya AC', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
