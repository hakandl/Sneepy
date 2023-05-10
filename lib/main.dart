import 'package:flutter/material.dart';
import 'package:sneepy/feature/auth/login/view/login_view.dart';
import 'package:sneepy/product/constant/colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: const LoginView(),
      theme: ThemeData(
        useMaterial3: true,
        // primaryColor: AppColors.blue,
        // primarySwatch: Colors.amber,
        colorSchemeSeed: AppColors.blue,
      ),
    );
  }
}
