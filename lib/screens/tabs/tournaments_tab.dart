import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TournamentsTab extends StatelessWidget {
  const TournamentsTab({super.key});

  final List<Map<String, dynamic>> _standings = const [
    {'pos': 1, 'team': 'Horoya AC', 'p': 14, 'w': 10, 'pts': 33},
    {'pos': 2, 'team': 'Hafia FC', 'p': 14, 'w': 9, 'pts': 30},
    {'pos': 3, 'team': 'AS Kaloum', 'p': 14, 'w': 8, 'pts': 27},
    {'pos': 4, 'team': 'Milo FC', 'p': 14, 'w': 7, 'pts': 24},
    {'pos': 5, 'team': 'CI Kamsar', 'p': 14, 'w': 6, 'pts': 21},
    {'pos': 6, 'team': 'Wakriya AC', 'p': 14, 'w': 5, 'pts': 19},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Classement de la Ligue 1', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
          const SizedBox(height: 6),
          const Text('Classement officiel saison 2026', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.filterBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                SizedBox(width: 30, child: Text('#', style: TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.bold))),
                Expanded(child: Text('Club', style: TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.bold))),
                SizedBox(width: 35, child: Text('MJ', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.bold))),
                SizedBox(width: 35, child: Text('V', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.bold))),
                SizedBox(width: 40, child: Text('PTS', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ..._standings.map((item) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                SizedBox(width: 30, child: Text('${item['pos']}', style: TextStyle(color: item['pos'] <= 2 ? AppTheme.primary : AppTheme.textSecondary, fontWeight: FontWeight.bold))),
                Expanded(child: Text(item['team'], style: const TextStyle(color: AppTheme.textMain, fontWeight: FontWeight.w600))),
                SizedBox(width: 35, child: Text('${item['p']}', textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.textSecondary))),
                SizedBox(width: 35, child: Text('${item['w']}', textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.textSecondary))),
                SizedBox(width: 40, child: Text('${item['pts']}', textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
