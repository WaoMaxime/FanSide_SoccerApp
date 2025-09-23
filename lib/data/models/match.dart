class Match {
  final int fixtureId;
  final String homeTeam;
  final String awayTeam;
  final String homeLogo;
  final String awayLogo;
  final bool isLive;
  final int homeScore;
  final int awayScore;
  final DateTime startTime;
  final String leagueName;
  final String leagueLogo;

  Match({
    required this.fixtureId,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeLogo,
    required this.awayLogo,
    required this.isLive,
    required this.homeScore,
    required this.awayScore,
    required this.startTime,
    required this.leagueName,
    required this.leagueLogo,
  });

  factory Match.fromApi(Map<String, dynamic> json) {
    return Match(
      fixtureId: json['fixture']['id'],
      homeTeam: json['teams']['home']['name'],
      awayTeam: json['teams']['away']['name'],
      homeLogo: json['teams']['home']['logo'],
      awayLogo: json['teams']['away']['logo'],
      isLive: json['fixture']['status']['short'] == 'LIVE',
      homeScore: json['goals']['home'] ?? 0,
      awayScore: json['goals']['away'] ?? 0,
      startTime: DateTime.parse(json['fixture']['date']),
      leagueName: json['league']['name'],
      leagueLogo: json['league']['logo'],
    );
  }
}
