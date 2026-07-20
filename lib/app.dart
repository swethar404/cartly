import 'package:flutter/material.dart';

import 'config/app_theme.dart';
import 'screens/auth/login_screen.dart';

class CartlyApp extends StatelessWidget {
  const CartlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cartly",
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}