import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/journees_service.dart';

class JourneesTab extends StatefulWidget {
  const JourneesTab({super.key});

  @override
  State<JourneesTab> createState() => _JourneesTabState();
}

class _JourneesTabState extends State<JourneesTab> {
  final JourneesService _service = JourneesService();
  String _statusFilter = 'Tous';

  @override
  void initState() {
    super.initState();
    _service.addListener(_onServiceUpdate);
  }

  @override
  void dispose() {
    _service.removeListener(_onServiceUpdate);
    super.dispose();
  }

  void _onServiceUpdate() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var tourMatches = _service.matches.where((m) => m.tourNumber == _service.selectedTour).toList();

    if (_statusFilter == 'À venir') {
      tourMatches = tourMatches.where((m) => !m.isFinished).toList();
    } else if (_statusFilter == 'Terminés') {
      tourMatches = tourMatches.where((m) => m.isFinished).toList();
    }

    final mainMatch = tourMatches.where((m) => m.isMain).toList();
    final otherMatches = tourMatches.where((m) => !m.isMain).toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.darkNav,
        elevation: 0,
        title: const Text('Tournois des Journées', style: TextStyle(color: AppTheme.textMain, fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(8)),
            child: const Center(
              child: Text('Guinée', style: TextStyle(color: AppTheme.buttonTextDark, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Disclaimer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.surfaceCard,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.border),
              ),
              child: const Text(
                'Données fictives — démonstration',
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 14),

            // Horizontal Tour Tabs (Journée 1 to 6)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(6, (i) {
                  final tourNum = i + 1;
                  final isSel = _service.selectedTour == tourNum;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text('Journée $tourNum'),
                      selected: isSel,
                      selectedColor: AppTheme.primary,
                      backgroundColor: AppTheme.surfaceCard,
                      labelStyle: TextStyle(
                        color: isSel ? AppTheme.buttonTextDark : AppTheme.textSecondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      onSelected: (_) => _service.setTour(tourNum),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 10),

            // Status Filter Buttons
            Row(
              children: ['Tous', 'À venir', 'Terminés'].map((st) {
                final isSel = _statusFilter == st;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: ElevatedButton(
                      onPressed: () => setState(() => _statusFilter = st),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSel ? AppTheme.primary : AppTheme.surfaceCard,
                        foregroundColor: isSel ? AppTheme.buttonTextDark : Colors.white,
                        elevation: 0,
                        minimumSize: const Size(0, 38),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.buttonRadius)),
                      ),
                      child: Text(st, style: TextStyle(fontSize: 12, fontWeight: isSel ? FontWeight.bold : FontWeight.normal)),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Main Featured Match with yellow vertical side stripe
            if (mainMatch.isNotEmpty) ...[
              const Text('Affiche Majeure du Tour', style: TextStyle(color: AppTheme.textMain, fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildMainFeaturedCard(context, mainMatch.first),
              const SizedBox(height: 16),
            ],

            // Other matches
            const Text('Autres Rencontres du Tour', style: TextStyle(color: AppTheme.textMain, fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (otherMatches.isEmpty && mainMatch.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(color: AppTheme.surfaceCard, borderRadius: BorderRadius.circular(AppTheme.cardRadius)),
                child: const Text('Aucun match pour ce filtre dans ce tour.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
              )
            else
              ...otherMatches.map((m) => _buildStandardMatchCard(context, m)),
          ],
        ),
      ),
    );
  }

  Widget _buildMainFeaturedCard(BuildContext context, TourMatch m) {
    final isFav = _service.favMatchIds.contains(m.id);
    return Card(
      color: AppTheme.surfaceCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.cardRadius)),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: AppTheme.primary, width: 4.5)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.cardRadius),
          onTap: () => _showMatchDetails(context, m),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: AppTheme.primary),
                        const SizedBox(width: 4),
                        Text('Journée ${m.tourNumber} • Match Phare', style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: AppTheme.border, borderRadius: BorderRadius.circular(6)),
                          child: Text(m.status, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _service.toggleFavorite(m.id),
                          child: Icon(isFav ? Icons.star_rounded : Icons.star_outline_rounded, color: isFav ? AppTheme.primary : AppTheme.textSecondary, size: 24),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppTheme.filterBg,
                            child: Text(m.codeA, style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                          const SizedBox(height: 6),
                          Text(m.teamA, textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.textMain, fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: m.score != null
                          ? Text(m.score!, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900))
                          : Text(m.time, style: const TextStyle(color: AppTheme.primary, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppTheme.filterBg,
                            child: Text(m.codeB, style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                          const SizedBox(height: 6),
                          Text(m.teamB, textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.textMain, fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(color: AppTheme.border, height: 22),
                Text(m.summary, textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStandardMatchCard(BuildContext context, TourMatch m) {
    return Card(
      color: AppTheme.surfaceCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.cardRadius)),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: () => _showMatchDetails(context, m),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        title: Text('${m.teamA} — ${m.teamB}', style: const TextStyle(color: AppTheme.textMain, fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text('${m.date} à ${m.time} • ${m.stadium}', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
        trailing: Text(m.score ?? m.status, style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 13)),
      ),
    );
  }

  void _showMatchDetails(BuildContext context, TourMatch m) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceCard,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Journée ${m.tourNumber} • ${m.date}', style: const TextStyle(color: AppTheme.primary, fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(m.codeA, style: const TextStyle(color: AppTheme.primary, fontSize: 26, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(m.score ?? 'VS', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                  ),
                  Text(m.codeB, style: const TextStyle(color: AppTheme.primary, fontSize: 26, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),
              Center(child: Text('${m.teamA} — ${m.teamB}', style: const TextStyle(color: AppTheme.textMain, fontSize: 15, fontWeight: FontWeight.bold))),
              const Divider(color: AppTheme.border, height: 22),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16, color: AppTheme.textSecondary),
                  const SizedBox(width: 8),
                  Expanded(child: Text(m.stadium, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13))),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.access_time_rounded, size: 16, color: AppTheme.textSecondary),
                  const SizedBox(width: 8),
                  Text('${m.time} • Statut : ${m.status}', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(10)),
                child: Text(m.summary, style: const TextStyle(color: Colors.white, fontSize: 13)),
              ),
              const SizedBox(height: 10),
              const Center(child: Text('Données fictives — démonstration', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontStyle: FontStyle.italic))),
            ],
          ),
        );
      },
    );
  }
}
