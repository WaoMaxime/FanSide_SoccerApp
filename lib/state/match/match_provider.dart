import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/match.dart';
import '../../data/repositories/match_repository.dart';
import '../../data/services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final matchRepositoryProvider = Provider<MatchRepository>(
      (ref) => MatchRepository(ref.read(apiServiceProvider)),
);

final liveMatchesProvider = FutureProvider<List<Match>>((ref) async {
  final repo = ref.read(matchRepositoryProvider);
  return repo.fetchLiveMatches();
});
