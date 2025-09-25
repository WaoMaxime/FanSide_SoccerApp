class Match {
  final int fixtureId;
  final String homeTeam;
  final String awayTeam;
  final String homeLogo;
  final String awayLogo;
  final int homeScore;
  final int awayScore;
  final DateTime startTime;
  final String leagueName;
  final String leagueLogo;

  final String statusShort;
  final String statusLong;
  final int? elapsed;
  final int? extra;

  Match({
    required this.fixtureId,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeLogo,
    required this.awayLogo,
    required this.homeScore,
    required this.awayScore,
    required this.startTime,
    required this.leagueName,
    required this.leagueLogo,
    required this.statusShort,
    required this.statusLong,
    this.elapsed,
    this.extra,
  });

  bool get isLive => ["1H", "2H", "ET"].contains(statusShort);
  bool get isUpcoming => statusShort == "NS";
  bool get isFinished => statusShort == "FT";

  factory Match.fromApi(Map<String, dynamic> json) {
    final status = json['fixture']['status'];
    return Match(
      fixtureId: json['fixture']['id'],
      homeTeam: json['teams']['home']['name'],
      awayTeam: json['teams']['away']['name'],
      homeLogo: json['teams']['home']['logo'],
      awayLogo: json['teams']['away']['logo'],
      homeScore: json['goals']['home'] ?? 0,
      awayScore: json['goals']['away'] ?? 0,
      startTime: DateTime.parse(json['fixture']['date']),
      leagueName: json['league']['name'],
      leagueLogo: json['league']['logo'],
      statusShort: status['short'],
      statusLong: status['long'],
      elapsed: status['elapsed'],
      extra: status['extra'],
    );
  }
}
