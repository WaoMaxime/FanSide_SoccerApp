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
      id: json['fixture']['id'],
      homeTeam: json['teams']['home']['name'],
      awayTeam: json['teams']['away']['name'],
      homeScore: json['goals']['home'] ?? 0,
      awayScore: json['goals']['away'] ?? 0,
      isLive: json['fixture']['status']['short'] == 'LIVE',
      startTime: DateTime.parse(
          json['fixture']['date']),
    );
  }
}

