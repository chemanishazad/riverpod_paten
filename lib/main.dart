import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_paten/core/route/routes.dart';
import 'package:riverpod_paten/core/theme/theme_provider.dart';
import 'package:riverpod_paten/core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('fr'),
        Locale('de'),
        Locale('ta'),
      ],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final goRouter = ref.watch(goRouterProvider);

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          title: 'Flutter Demo',
          themeMode: themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          routerConfig: goRouter,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
        );
      },
    );
  }
}
