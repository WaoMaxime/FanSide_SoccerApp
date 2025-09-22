import 'package:flutter/material.dart';
import '../../../data/models/match.dart';

class MatchDetailScreen extends StatelessWidget {
  final Match match;

  const MatchDetailScreen({required this.match, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${match.homeTeam} vs ${match.awayTeam}")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: match.isLive ? Colors.red[400] : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                match.isLive ? "LIVE" : "Upcoming",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Icon(Icons.sports_soccer, size: 48),
                    const SizedBox(height: 8),
                    Text(match.homeTeam, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(
                  "${match.homeScore} - ${match.awayScore}",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    const Icon(Icons.sports_soccer, size: 48),
                    const SizedBox(height: 8),
                    Text(match.awayTeam, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            Text(
              "Start Time: ${match.startTime.day.toString().padLeft(2,'0')}-${match.startTime.month.toString().padLeft(2,'0')}-${match.startTime.year} ${match.startTime.hour.toString().padLeft(2,'0')}:${match.startTime.minute.toString().padLeft(2,'0')}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    Text("Match Stats", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    Text("Possession: Home 55% - Away 45%"),
                    Text("Shots on Target: Home 5 - Away 3"),
                    Text("Corners: Home 4 - Away 2"),
                    Text("Yellow Cards: Home 1 - Away 2"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
