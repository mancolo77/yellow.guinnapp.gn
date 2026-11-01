import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class MatchesTab extends StatefulWidget {
  const MatchesTab({super.key});
  @override
  State<MatchesTab> createState() => _MatchesTabState();
}

class _MatchesTabState extends State<MatchesTab> {
  int _selectedRound = 1;

  final List<Map<String, dynamic>> _guineaMatches = [
    {'r': 1, 't1': 'Horoya AC', 't2': 'Hafia FC', 'score': '2 : 1', 'stadium': '28 September Stadium', 'status': 'Finished'},
    {'r': 1, 't1': 'AS Kaloum', 't2': 'Milo FC', 'score': '1 : 1', 'stadium': 'Mission Stadium', 'status': 'Finished'},
    {'r': 2, 't1': 'CI Kamsar', 't2': 'SOAR Academy', 'score': 'VS', 'stadium': 'Friendship Stadium', 'status': 'Upcoming • 16:00'},
    {'r': 2, 't1': 'Flamme Olympique', 't2': 'Wakriya AC', 'score': 'VS', 'stadium': 'Lansana Conte Stadium', 'status': 'Upcoming • 18:30'},
  ];

  @override
  Widget build(BuildContext context) {
    final list = _guineaMatches.where((e) => e['r'] == _selectedRound).toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Guinea League 1', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppTheme.filterBg, borderRadius: BorderRadius.circular(8)),
                child: const Text('Guinea Football', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Match Center • Live & Upcoming Fixtures', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
          const SizedBox(height: 16),
          Row(
            children: [1, 2].map((r) {
              final sel = _selectedRound == r;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text('Round $r'),
                  selected: sel,
                  onSelected: (_) => setState(() => _selectedRound = r),
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
                      Text(m['status'], style: const TextStyle(color: AppTheme.primary, fontSize: 12, fontWeight: FontWeight.bold)),
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
