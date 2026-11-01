import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class MatchesTab extends StatefulWidget {
  const MatchesTab({super.key});
  @override
  State<MatchesTab> createState() => _MatchesTabState();
}

class _MatchesTabState extends State<MatchesTab> {
  int _selectedJournee = 1;

  final List<Map<String, dynamic>> _guineaMatches = [
    {'j': 1, 't1': 'Horoya AC', 't2': 'Hafia FC', 'score': '2 : 1', 'stadium': 'Stade du 28 Septembre', 'date': 'Terminé'},
    {'j': 1, 't1': 'AS Kaloum', 't2': 'Milo FC', 'score': '1 : 1', 'stadium': 'Stade de la Mission', 'date': 'Terminé'},
    {'j': 2, 't1': 'CI Kamsar', 't2': 'SOAR Académie', 'score': 'VS', 'stadium': 'Stade de l\'Amitié', 'date': 'À venir - 16:00'},
    {'j': 2, 't1': 'Flamme Olympique', 't2': 'Wakriya AC', 'score': 'VS', 'stadium': 'Stade Général Lansana Conté', 'date': 'À venir - 18:30'},
  ];

  @override
  Widget build(BuildContext context) {
    final list = _guineaMatches.where((e) => e['j'] == _selectedJournee).toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Ligue 1 Guinée', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppTheme.filterBg, borderRadius: BorderRadius.circular(8)),
                child: const Text('Guinée Football', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Données fictives — démonstration', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
          const SizedBox(height: 16),
          // Journees chips
          Row(
            children: [1, 2].map((j) {
              final sel = _selectedJournee == j;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text('Journée $j'),
                  selected: sel,
                  onSelected: (_) => setState(() => _selectedJournee = j),
                  selectedColor: AppTheme.primary,
                  backgroundColor: AppTheme.filterBg,
                  labelStyle: TextStyle(color: sel ? AppTheme.buttonTextDark : AppTheme.textMain, fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          ...list.map((m) => Card(
            color: AppTheme.surfaceCard,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(m['stadium'], style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                      Text(m['date'], style: const TextStyle(color: AppTheme.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(m['t1'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textMain))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(color: AppTheme.filterBg, borderRadius: BorderRadius.circular(8)),
                        child: Text(m['score'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                      ),
                      Expanded(child: Text(m['t2'], textAlign: TextAlign.right, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textMain))),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
