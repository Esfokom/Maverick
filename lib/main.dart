import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/signup_page.dart';
import 'features/auth/screens/forgot_password_page.dart';
import 'app/screens/main_navigation.dart';
import 'core/screens/notifications_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const MainNavigation(),
        '/signup': (context) => const SignUpPage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/notifications': (context) =>
            const NotificationsPage(notifications: []),
      },
      initialRoute: '/',
    );
  }
}
