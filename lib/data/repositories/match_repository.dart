import '../models/match.dart';
import '../services/api_service.dart';

class MatchRepository {
  final ApiService apiService;

  MatchRepository(this.apiService);

  Future<List<Match>> fetchLiveMatches() async {
    return await apiService.getLiveMatches();
  }
}
