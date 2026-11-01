import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  final List<Map<String, String>> _clubs = const [
    {'name': 'Horoya AC', 'city': 'Conakry • Ligue 1 Guinée'},
    {'name': 'Hafia FC', 'city': 'Conakry • Ligue 1 Guinée'},
    {'name': 'AS Kaloum', 'city': 'Kaloum • Ligue 1 Guinée'},
    {'name': 'Milo FC', 'city': 'Kankan • Ligue 1 Guinée'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Clubs Favoris', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
          const SizedBox(height: 6),
          const Text('Équipes suivies et faits marquants', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
          const SizedBox(height: 16),
          ..._clubs.map((c) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.primary,
                  child: const Icon(Icons.star_rounded, color: AppTheme.buttonTextDark),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.textMain)),
                      const SizedBox(height: 4),
                      Text(c['city']!, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.star, color: AppTheme.primary),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
