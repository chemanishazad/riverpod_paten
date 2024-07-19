import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_paten/provider/authProvider/authProvider.dart';
import 'package:riverpod_paten/screens/home/home_page.dart';
import 'package:riverpod_paten/screens/login/login_screen.dart';
import 'package:riverpod_paten/screens/splash/splash_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final isLoggedIn = authState != null;

  return GoRouter(
    initialLocation: isLoggedIn ? '/home' : '/login',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
});
