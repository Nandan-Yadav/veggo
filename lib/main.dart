import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:veggo/Auth/controller/signin_controller.dart';
import 'package:veggo/Auth/controller/signup_controller.dart';
import 'package:veggo/Auth/view/otp_screen_view.dart';
import 'package:veggo/Auth/view/signin_screen_view.dart';
import 'package:veggo/Auth/view/signup_screen_view.dart';
import 'package:veggo/Auth/view_model/login_view_model.dart';
import 'package:veggo/Auth/view_model/otp_view_model.dart';
import 'package:veggo/firebase_options.dart';
import 'package:veggo/onboarding/controller/bottomsheet_navigation_provider.dart';
import 'package:veggo/screens/auth_screen.dart';
import 'package:veggo/screens/home_screen.dart';
import 'package:veggo/screens/onboarding_screen.dart';
import 'package:veggo/utilities/local_storage/onboarding_shared_preferences.dart';
import './utilities/themes/theme.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.setSettings(
    appVerificationDisabledForTesting: true, // For testing only
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize SharedPreferences and retrieve onboarding status
  final bool onboarded = await LocalStorageService.isOnboardingCompleted();

  debugPrint('Onboarding status: $onboarded');
  FlutterNativeSplash.remove();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BottomsheetNavigationProvider()),
      ChangeNotifierProvider(create: (_) => OtpViewModel()),
      ChangeNotifierProvider(create: (_) => LoginViewModel()),
      //ChangeNotifierProvider(create: (_) => CAuthProvider()),
      ChangeNotifierProvider(create: (_) => SignInPhoneFieldController()),
      ChangeNotifierProvider(create: (_) => SignInCheckboxStateController()),
      ChangeNotifierProvider(create: (_) => SignUpNameFieldController()),
      ChangeNotifierProvider(create: (_) => SignUpEmailFieldController()),
      ChangeNotifierProvider(create: (_) => SignUpPhoneFieldController()),
      ChangeNotifierProvider(create: (_) => SignUpCheckboxStateController()),
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
      home: onboarded ? const AuthScreen() : const OnboardingScreen(),
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/Auth': (context) => const AuthScreen(),
        '/sign_in': (context) => SignInScreenView(),
        '/sign_up': (context) => SignUpScreenView(),
        '/otp': (context) => OtpScreenView(
              verificationId: '',
            ),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
