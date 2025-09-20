// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/router/app_router.dart'; // if you use router
import 'core/theme/theme.dart';
import 'core/theme/theme_notifier.dart';
import 'core/storage/storage_service.dart'; // <-- where sharedPrefsProvider is

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sp = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // inject the instance so reads don’t throw
        sharedPrefsProvider.overrideWithValue(sp),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final router = ref.watch(routerProvider); // if using go_router

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: UAppTheme.lightTheme,
      darkTheme: UAppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
