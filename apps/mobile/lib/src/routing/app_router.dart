import 'package:chapter_house/src/features/bootstrap/presentation/bootstrap_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: BootstrapScreen.routePath,
  routes: [
    GoRoute(
      path: BootstrapScreen.routePath,
      name: BootstrapScreen.routeName,
      builder: (context, state) => const BootstrapScreen(),
    ),
  ],
);
