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
    final startTimeFormatted =
    DateFormat('dd MMM yyyy, HH:mm').format(match.startTime);
    String formatMatchTime(Match match) {
      if (match.elapsed == null) return match.statusLong;

      if (match.extra != null && match.extra! > 0) {
        return "${match.elapsed}+${match.extra}'";
      }

      return "${match.elapsed}'";
    }


    return Scaffold(
      appBar: AppBar(
        title: Text("${match.homeTeam} vs ${match.awayTeam}", style: TextStyle(fontSize: 14)),
        backgroundColor: Colors.black.withOpacity(0.6),
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://wallpapers.com/images/high/soccer-field-background-1920-x-1200-ko1b7myxotujjsjk.webp",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: match.isUpcoming
                        ? Colors.green[400]
                        : match.isLive
                        ? Colors.red[400]
                        : Colors.grey[600],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    match.isUpcoming
                        ? "Upcoming"
                        : match.isFinished
                        ? "FT"
                        : formatMatchTime(match),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),


                const SizedBox(height: 20),

                Card(
                  color: Colors.black.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: match.homeLogo,
                                    width: 60,
                                    height: 60,
                                    placeholder: (_, __) => const CircleAvatar(
                                        radius: 30, backgroundColor: Colors.grey),
                                    errorWidget: (_, __, ___) => const CircleAvatar(
                                        radius: 30, backgroundColor: Colors.grey),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    match.homeTeam,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                AnimatedDigitWidget(
                                  value: match.homeScore,
                                  textStyle: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  duration: const Duration(milliseconds: 500),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "-",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                AnimatedDigitWidget(
                                  value: match.awayScore,
                                  textStyle: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  duration: const Duration(milliseconds: 500),
                                ),
                              ],
                            ),

                            SizedBox(
                              width: 100,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: match.awayLogo,
                                    width: 60,
                                    height: 60,
                                    placeholder: (_, __) => const CircleAvatar(
                                        radius: 30, backgroundColor: Colors.grey),
                                    errorWidget: (_, __, ___) => const CircleAvatar(
                                        radius: 30, backgroundColor: Colors.grey),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    match.awayTeam,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),


                Card(
                  color: Colors.black.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (match.leagueLogo.isNotEmpty)
                              Image.network(match.leagueLogo,
                                  width: 24, height: 24),
                            const SizedBox(width: 8),
                            Text(
                              match.leagueName,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Kick-off: $startTimeFormatted",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                if (["2H", "HT", "ET", "FT"].contains(match.statusShort) || match.isFinished)
                Card(
                  color: Colors.black.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text(
                          "Score Breakdown",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (["2H", "HT", "ET", "FT"].contains(match.statusShort))
                              Column(
                                children: [
                                  const Text(
                                    "Halftime",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Text(
                                    "${match.homeScore} - ${match.awayScore}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),

                            if (match.isFinished)
                              Column(
                                children: [
                                  const Text(
                                    "Fulltime",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Text(
                                    "${match.homeScore} - ${match.awayScore}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
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
        ],
      ),
    );
  }
}

