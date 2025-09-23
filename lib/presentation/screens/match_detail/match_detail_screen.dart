import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../data/models/match.dart';
import 'package:intl/intl.dart';
import 'package:animated_digit/animated_digit.dart';

class MatchDetailScreen extends StatelessWidget {
  final Match match;

  const MatchDetailScreen({required this.match, super.key});

  @override
  Widget build(BuildContext context) {
    final startTimeFormatted = DateFormat('dd MMM yyyy, HH:mm').format(match.startTime);

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
                    CachedNetworkImage(
                      imageUrl: match.homeLogo,
                      width: 60,
                      height: 60,
                      placeholder: (_, __) => const CircleAvatar(radius: 30, backgroundColor: Colors.grey),
                      errorWidget: (_, __, ___) => const CircleAvatar(radius: 30, backgroundColor: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(match.homeTeam,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                AnimatedDigitWidget(
                  value: match.homeScore,
                  textStyle: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  duration: const Duration(milliseconds: 500),
                ),
                const Text("-", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                AnimatedDigitWidget(
                  value: match.awayScore,
                  textStyle: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  duration: const Duration(milliseconds: 500),
                ),
                Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: match.awayLogo,
                      width: 60,
                      height: 60,
                      placeholder: (_, __) => const CircleAvatar(radius: 30, backgroundColor: Colors.grey),
                      errorWidget: (_, __, ___) => const CircleAvatar(radius: 30, backgroundColor: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(match.awayTeam,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (match.leagueLogo.isNotEmpty)
                  Image.network(match.leagueLogo, width: 24, height: 24),
                const SizedBox(width: 8),
                Text(match.leagueName, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),

            Text("Kick-off: $startTimeFormatted", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),

            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text("Score Breakdown",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Text("Halftime"),
                            Text("${match.homeScore} - ${match.awayScore}"),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("Fulltime"),
                            Text("${match.homeScore} - ${match.awayScore}"),
                          ],
                        ),
                      ],
                    ),
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
