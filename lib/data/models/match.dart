class Match {
  final int id;
  final String homeTeam;
  final String awayTeam;
  final int homeScore;
  final int awayScore;
  final DateTime startTime;
  final bool isLive;

  Match({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.startTime,
    required this.isLive,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      homeTeam: json['home_team'],
      awayTeam: json['away_team'],
      homeScore: json['home_score'] ?? 0,
      awayScore: json['away_score'] ?? 0,
      startTime: DateTime.parse(json['start_time']),
      isLive: json['is_live'] ?? false,
    );
  }
}
