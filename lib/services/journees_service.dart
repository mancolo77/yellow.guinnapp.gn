import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TourMatch {
  final String id;
  final int tourNumber; // 1 to 6
  final String teamA;
  final String codeA;
  final String teamB;
  final String codeB;
  final String date;
  final String time;
  final String? score;
  final String stadium;
  final String status;
  final String summary;
  final bool isMain;

  const TourMatch({
    required this.id,
    required this.tourNumber,
    required this.teamA,
    required this.codeA,
    required this.teamB,
    required this.codeB,
    required this.date,
    required this.time,
    this.score,
    required this.stadium,
    required this.status,
    required this.summary,
    this.isMain = false,
  });

  bool get isFinished => score != null || status == 'Terminé';
}

class JourneesService with ChangeNotifier {
  static final JourneesService _instance = JourneesService._internal();
  factory JourneesService() => _instance;
  JourneesService._internal();

  final Set<String> _favMatchIds = {'tm_1', 'tm_5'};
  int _selectedTour = 1;
  String _userName = 'Supporter Conakry';
  String _favTeam = 'Horoya AC';

  Set<String> get favMatchIds => Set.unmodifiable(_favMatchIds);
  int get selectedTour => _selectedTour;
  String get userName => _userName;
  String get favTeam => _favTeam;

  final List<String> teams = const [
    'Horoya AC',
    'Hafia FC',
    'AS Kaloum',
    'CI Kamsar',
    'Satellite FC',
    'Milo FC Kankan',
    'Wakriya AC',
    'Flamme Olympique',
  ];

  final List<TourMatch> matches = const [
    // Tour 1
    TourMatch(
      id: 'tm_1',
      tourNumber: 1,
      teamA: 'Horoya AC',
      codeA: 'HAC',
      teamB: 'Hafia FC',
      codeB: 'HFC',
      date: 'Aujourd\'hui',
      time: '16:00',
      score: '2 - 1',
      stadium: 'Stade Général Lansana Conté, Nongo',
      status: 'Terminé',
      summary: 'Le grand choc de la 1ère journée voit la victoire de Horoya AC.',
      isMain: true,
    ),
    TourMatch(
      id: 'tm_2',
      tourNumber: 1,
      teamA: 'AS Kaloum',
      codeA: 'ASK',
      teamB: 'CI Kamsar',
      codeB: 'CIK',
      date: 'Aujourd\'hui',
      time: '18:15',
      score: '1 - 0',
      stadium: 'Stade de la Mission, Kaloum',
      status: 'Terminé',
      summary: 'Kaloum démarre par une victoire nette et appliquée.',
    ),
    TourMatch(
      id: 'tm_3',
      tourNumber: 1,
      teamA: 'Satellite FC',
      codeA: 'SFC',
      teamB: 'Milo FC Kankan',
      codeB: 'MFC',
      date: 'Demain',
      time: '16:00',
      score: null,
      stadium: 'Stade du 28 Septembre, Conakry',
      status: 'À venir',
      summary: 'Opposition attendue entre la vivacité de Satellite et le bloc de Kankan.',
    ),
    TourMatch(
      id: 'tm_4',
      tourNumber: 1,
      teamA: 'Wakriya AC',
      codeA: 'WAC',
      teamB: 'Flamme Olympique',
      codeB: 'FLA',
      date: 'Demain',
      time: '18:00',
      score: null,
      stadium: 'Stade de l\'Amitié, Kamsar',
      status: 'À venir',
      summary: 'Wakriya entend faire la différence dès l\'entame de match.',
    ),

    // Tour 2
    TourMatch(
      id: 'tm_5',
      tourNumber: 2,
      teamA: 'Hafia FC',
      codeA: 'HFC',
      teamB: 'AS Kaloum',
      codeB: 'ASK',
      date: '04 Nov',
      time: '16:00',
      score: null,
      stadium: 'Stade Petit Sory, Nongo',
      status: 'À venir',
      summary: 'Le Classico de Guinée : passion et ferveur garanties.',
      isMain: true,
    ),
    TourMatch(
      id: 'tm_6',
      tourNumber: 2,
      teamA: 'CI Kamsar',
      codeA: 'CIK',
      teamB: 'Horoya AC',
      codeB: 'HAC',
      date: '04 Nov',
      time: '18:00',
      score: null,
      stadium: 'Stade de l\'Amitié, Kamsar',
      status: 'À venir',
      summary: 'Déplacement sous haute tension pour le club de Conakry.',
    ),
    TourMatch(
      id: 'tm_7',
      tourNumber: 2,
      teamA: 'Milo FC Kankan',
      codeA: 'MFC',
      teamB: 'Wakriya AC',
      codeB: 'WAC',
      date: '05 Nov',
      time: '16:00',
      score: null,
      stadium: 'Stade M\'Balou Mady Diakité, Kankan',
      status: 'À venir',
      summary: 'Duel palpitant au cœur de la Haute-Guinée.',
    ),
    TourMatch(
      id: 'tm_8',
      tourNumber: 2,
      teamA: 'Flamme Olympique',
      codeA: 'FLA',
      teamB: 'Satellite FC',
      codeB: 'SFC',
      date: '05 Nov',
      time: '18:00',
      score: null,
      stadium: 'Stade de la Mission, Kaloum',
      status: 'À venir',
      summary: 'Choc tactique entre deux formations ambitieuses.',
    ),

    // Tour 3
    TourMatch(
      id: 'tm_9',
      tourNumber: 3,
      teamA: 'Horoya AC',
      codeA: 'HAC',
      teamB: 'Milo FC Kankan',
      codeB: 'MFC',
      date: '08 Nov',
      time: '16:00',
      score: null,
      stadium: 'Stade Général Lansana Conté, Nongo',
      status: 'À venir',
      summary: 'Le leader reçoit son dauphin pour le choc au sommet.',
      isMain: true,
    ),
    TourMatch(
      id: 'tm_10',
      tourNumber: 3,
      teamA: 'AS Kaloum',
      codeA: 'ASK',
      teamB: 'Wakriya AC',
      codeB: 'WAC',
      date: '08 Nov',
      time: '18:15',
      score: null,
      stadium: 'Stade de la Mission, Kaloum',
      status: 'À venir',
      summary: 'Kaloum à la recherche de points précieux pour le podium.',
    ),
    TourMatch(
      id: 'tm_11',
      tourNumber: 3,
      teamA: 'Hafia FC',
      codeA: 'HFC',
      teamB: 'Flamme Olympique',
      codeB: 'FLA',
      date: '09 Nov',
      time: '16:00',
      score: null,
      stadium: 'Stade Petit Sory, Nongo',
      status: 'À venir',
      summary: 'Hafia veut confirmer sa solidité défensive.',
    ),
    TourMatch(
      id: 'tm_12',
      tourNumber: 3,
      teamA: 'CI Kamsar',
      codeA: 'CIK',
      teamB: 'Satellite FC',
      codeB: 'SFC',
      date: '09 Nov',
      time: '18:00',
      score: null,
      stadium: 'Stade de l\'Amitié, Kamsar',
      status: 'À venir',
      summary: 'Rencontre indécise entre deux équipes proches au classement.',
    ),

    // Tour 4
    TourMatch(
      id: 'tm_13',
      tourNumber: 4,
      teamA: 'Wakriya AC',
      codeA: 'WAC',
      teamB: 'Horoya AC',
      codeB: 'HAC',
      date: '12 Nov',
      time: '16:00',
      score: null,
      stadium: 'Stade de l\'Amitié, Kamsar',
      status: 'À venir',
      summary: 'Wakriya tentera de freiner la marche en avant de Horoya.',
      isMain: true,
    ),
    TourMatch(
      id: 'tm_14',
      tourNumber: 4,
      teamA: 'Satellite FC',
      codeA: 'SFC',
      teamB: 'Hafia FC',
      codeB: 'HFC',
      date: '12 Nov',
      time: '18:15',
      score: null,
      stadium: 'Stade du 28 Septembre, Conakry',
      status: 'À venir',
      summary: 'Duel de la capitale avec une forte affluence prévue.',
    ),
    TourMatch(
      id: 'tm_15',
      tourNumber: 4,
      teamA: 'Flamme Olympique',
      codeA: 'FLA',
      teamB: 'AS Kaloum',
      codeB: 'ASK',
      date: '13 Nov',
      time: '16:00',
      score: null,
      stadium: 'Stade de la Mission, Kaloum',
      status: 'À venir',
      summary: 'Rencontre physique où chaque duel comptera.',
    ),
    TourMatch(
      id: 'tm_16',
      tourNumber: 4,
      teamA: 'Milo FC Kankan',
      codeA: 'MFC',
      teamB: 'CI Kamsar',
      codeB: 'CIK',
      date: '13 Nov',
      time: '16:00',
      score: null,
      stadium: 'Stade M\'Balou Mady Diakité, Kankan',
      status: 'À venir',
      summary: 'Les attaquants de Milo FC face au gardien de Kamsar.',
    ),

    // Tour 5
    TourMatch(
      id: 'tm_17',
      tourNumber: 5,
      teamA: 'Horoya AC',
      codeA: 'HAC',
      teamB: 'AS Kaloum',
      codeB: 'ASK',
      date: '16 Nov',
      time: '16:00',
      score: null,
      stadium: 'Stade Général Lansana Conté, Nongo',
      status: 'À venir',
      summary: 'Deuxième manche du derby historique de Guinée.',
      isMain: true,
    ),
    TourMatch(
      id: 'tm_18',
      tourNumber: 5,
      teamA: 'Hafia FC',
      codeA: 'HFC',
      teamB: 'CI Kamsar',
      codeB: 'CIK',
      date: '16 Nov',
      time: '18:30',
      score: null,
      stadium: 'Stade Petit Sory, Nongo',
      status: 'À venir',
      summary: 'Bataille tactique entre deux entraîneurs chevronnés.',
    ),
    TourMatch(
      id: 'tm_19',
      tourNumber: 5,
      teamA: 'Satellite FC',
      codeA: 'SFC',
      teamB: 'Wakriya AC',
      codeB: 'WAC',
      date: '17 Nov',
      time: '16:00',
      score: null,
      stadium: 'Stade du 28 Septembre, Conakry',
      status: 'À venir',
      summary: 'Chacune des équipes cherchera à imposer son tempo.',
    ),
    TourMatch(
      id: 'tm_20',
      tourNumber: 5,
      teamA: 'Flamme Olympique',
      codeA: 'FLA',
      teamB: 'Milo FC Kankan',
      codeB: 'MFC',
      date: '17 Nov',
      time: '18:00',
      score: null,
      stadium: 'Stade de la Mission, Kaloum',
      status: 'À venir',
      summary: 'Milo FC se déplace avec la ferme intention d\'engranger 3 points.',
    ),

    // Tour 6
    TourMatch(
      id: 'tm_21',
      tourNumber: 6,
      teamA: 'AS Kaloum',
      codeA: 'ASK',
      teamB: 'Hafia FC',
      codeB: 'HFC',
      date: '20 Nov',
      time: '16:00',
      score: null,
      stadium: 'Stade de la Mission, Kaloum',
      status: 'À venir',
      summary: 'Dernière journée de la phase aller : enjeu maximal.',
      isMain: true,
    ),
    TourMatch(
      id: 'tm_22',
      tourNumber: 6,
      teamA: 'Horoya AC',
      codeA: 'HAC',
      teamB: 'Satellite FC',
      codeB: 'SFC',
      date: '20 Nov',
      time: '18:30',
      score: null,
      stadium: 'Stade Général Lansana Conté, Nongo',
      status: 'À venir',
      summary: 'Horoya visera la tête du classement avant la trêve.',
    ),
    TourMatch(
      id: 'tm_23',
      tourNumber: 6,
      teamA: 'CI Kamsar',
      codeA: 'CIK',
      teamB: 'Wakriya AC',
      codeB: 'WAC',
      date: '21 Nov',
      time: '16:00',
      score: null,
      stadium: 'Stade de l\'Amitié, Kamsar',
      status: 'À venir',
      summary: 'Le derby minier de Boké s\'annonce électrique.',
    ),
    TourMatch(
      id: 'tm_24',
      tourNumber: 6,
      teamA: 'Milo FC Kankan',
      codeA: 'MFC',
      teamB: 'Flamme Olympique',
      codeB: 'FLA',
      date: '21 Nov',
      time: '16:00',
      score: null,
      stadium: 'Stade M\'Balou Mady Diakité, Kankan',
      status: 'À venir',
      summary: 'Clôture de la 6ème journée dans l\'arène de Kankan.',
    ),
  ];

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final fav = prefs.getStringList('fav_matches_journees');
      if (fav != null) {
        _favMatchIds.clear();
        _favMatchIds.addAll(fav);
      }
      final tour = prefs.getInt('selected_tour_journees');
      if (tour != null) _selectedTour = tour;
      final name = prefs.getString('user_name_journees');
      if (name != null) _userName = name;
      final team = prefs.getString('fav_team_journees');
      if (team != null) _favTeam = team;
      notifyListeners();
    } catch (_) {}
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('fav_matches_journees', _favMatchIds.toList());
      await prefs.setInt('selected_tour_journees', _selectedTour);
      await prefs.setString('user_name_journees', _userName);
      await prefs.setString('fav_team_journees', _favTeam);
    } catch (_) {}
  }

  void setTour(int t) {
    _selectedTour = t;
    _save();
    notifyListeners();
  }

  void toggleFavorite(String id) {
    if (_favMatchIds.contains(id)) {
      _favMatchIds.remove(id);
    } else {
      _favMatchIds.add(id);
    }
    _save();
    notifyListeners();
  }

  void updateProfile(String name, String team) {
    _userName = name;
    _favTeam = team;
    _save();
    notifyListeners();
  }

  void resetData() {
    _favMatchIds.clear();
    _selectedTour = 1;
    _userName = 'Supporter Conakry';
    _favTeam = 'Horoya AC';
    _save();
    notifyListeners();
  }
}

