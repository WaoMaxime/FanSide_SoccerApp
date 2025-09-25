import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/match.dart';
import 'match_provider.dart';

class LiveMatchesNotifier extends AutoDisposeAsyncNotifier<List<Match>> {
  Timer? _timer;

  @override
  Future<List<Match>> build() async {
    _startAutoRefresh();
    return _fetchMatches();
  }

  Future<List<Match>> _fetchMatches() async {
    final repo = ref.read(matchRepositoryProvider);
    return await repo.fetchLiveMatches();
  }

  void _startAutoRefresh() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 30), (_) async {
      try {
        final matches = await _fetchMatches();
        state = AsyncValue.data(matches);
      } catch (e, st) {
        state = AsyncValue.error(e, st);
      }
    });

    ref.onDispose(() {
      _timer?.cancel();
    });
  }
}

final liveMatchesProvider =
AutoDisposeAsyncNotifierProvider<LiveMatchesNotifier, List<Match>>(
  LiveMatchesNotifier.new,
);



