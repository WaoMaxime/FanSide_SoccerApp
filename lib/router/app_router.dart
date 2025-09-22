import 'package:go_router/go_router.dart';
import '../presentation/screens/login/login_screen.dart';
import '../presentation/screens/login/new_user_screen.dart';
import '../presentation/screens/login/forgot_password_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../data/models/match.dart';
import '../presentation/screens/match_detail/match_detail_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) => LoginScreen(),
      routes: [
        GoRoute(
          path: 'new-user',
          name: 'newUser',
          builder: (context, state) => const NewUserScreen(),
        ),
        GoRoute(
          path: 'forgot-password',
          name: 'forgotPassword',
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'match',
          name: 'matchDetail',
          builder: (context, state) {
            final match = state.extra as Match;
            return MatchDetailScreen(match: match);
          },
        ),
      ],
    ),
  ],
);
