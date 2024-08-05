import 'package:flutter/material.dart';
import 'package:galaxy_planets/provider/like_provider.dart';
import 'package:galaxy_planets/provider/theme_provider.dart';
import 'package:galaxy_planets/screens/pages/splash_screen.dart';
import 'package:provider/provider.dart';

import 'screens/pages/home_page.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => LikeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
    ], child: const ThemePRVDR());
  }
}

class ThemePRVDR extends StatelessWidget {
  const ThemePRVDR({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode:
          (Provider.of<ThemeProvider>(context).defaultThemeMode == "Light")
              ? ThemeMode.light
              : (Provider.of<ThemeProvider>(context).defaultThemeMode == "Dark")
                  ? ThemeMode.dark
                  : ThemeMode.system,
      initialRoute: 'splash',
      routes: {
        '/': (_) => const HomePage(),
        'splash': (_) => const SplashScreen(),
      },
    );
  }
}
