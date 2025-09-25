import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../state/match/match_provider.dart';
import '../../../data/models/match.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animated_digit/animated_digit.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveMatchesAsync = ref.watch(liveMatchesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Scores'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => context.goNamed('profile'),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(liveMatchesProvider),
          ),
        ],
      ),
      body: liveMatchesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (matches) {
          final liveMatches =
          matches.where((m) => m.isLive).toList(growable: false);
          final upcomingMatches =
          matches.where((m) => !m.isLive).toList(growable: false);

          return RefreshIndicator(
            onRefresh: () async => ref.refresh(liveMatchesProvider),
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                if (liveMatches.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'LIVE MATCHES',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ...liveMatches.map((match) => MatchCard(match: match)),
                if (upcomingMatches.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'UPCOMING MATCHES',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ...upcomingMatches.map((match) => MatchCard(match: match)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  final Match match;
  const MatchCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final timeFormatted = DateFormat('HH:mm, dd MMM').format(match.startTime);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Color(0xC51379CE),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.goNamed('matchDetail', extra: match),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: match.leagueLogo,
                    width: 20,
                    height: 20,
                    errorWidget: (_, __, ___) => const Icon(Icons.sports_soccer, size: 20),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      match.leagueName,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    timeFormatted,
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: match.homeLogo,
                          width: 40,
                          height: 40,
                          placeholder: (_, __) => const CircleAvatar(radius: 20, backgroundColor: Colors.grey),
                          errorWidget: (_, __, ___) => const CircleAvatar(radius: 20, backgroundColor: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          match.homeTeam,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      if (match.isLive)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text("LIVE", style: TextStyle(color: Colors.white, fontSize: 12)),
                        )
                      else
                        Text("Upcoming", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedDigitWidget(
                            value: match.homeScore,
                            textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 6),
                          const Text("-", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 6),
                          AnimatedDigitWidget(
                            value: match.awayScore,
                            textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: match.awayLogo,
                          width: 40,
                          height: 40,
                          placeholder: (_, __) => const CircleAvatar(radius: 20, backgroundColor: Colors.grey),
                          errorWidget: (_, __, ___) => const CircleAvatar(radius: 20, backgroundColor: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          match.awayTeam,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w600),
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
    );
  }
}

