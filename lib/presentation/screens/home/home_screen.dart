import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../state/match/match_provider.dart';
import '../../../data/models/match.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveMatches = ref.watch(liveMatchesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Live Scores')),
      body: liveMatches.when(
        data: (matches) => ListView.builder(
          itemCount: matches.length,
          itemBuilder: (context, index) {
            final Match match = matches[index];
            return ListTile(
              title: Text("${match.homeTeam} vs ${match.awayTeam}"),
              subtitle: Text(
                match.isLive
                    ? "Live: ${match.homeScore} - ${match.awayScore}"
                    : "Starts at ${match.startTime.hour.toString().padLeft(2,'0')}:${match.startTime.minute.toString().padLeft(2,'0')}",
              ),
              onTap: () {
                context.goNamed(
                  'matchDetail',
                  extra: matches[index],
                );
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
