import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:veggo/onboarding/controller/bottomsheet_navigation_provider.dart';
import 'package:veggo/screens/home_screen.dart';
import 'package:veggo/screens/onboarding_screen.dart';
import 'package:veggo/utilities/local_storage/onboarding_shared_preferences.dart';
import './utilities/themes/theme.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize SharedPreferences and retrive onboarding status
  final bool onboarded = await LocalStorageService.isOnboardingCompleted();

  debugPrint('Onboarding status: $onboarded');
  FlutterNativeSplash.remove();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BottomsheetNavigationProvider()),
    ],
    child: MyApp(onboarded: onboarded),
  ));
}

class MyApp extends StatelessWidget {
  final bool onboarded;

  const MyApp({super.key, required this.onboarded});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Veggo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: onboarded ? const HomeScreen() : const OnboardingScreen(),
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
