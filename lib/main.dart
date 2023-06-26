import 'package:stock_app/ui/pages/home/home_page.dart';
import 'package:stock_app/ui/pages/inventory/inventory_page.dart';
import 'package:stock_app/ui/pages/login/login_page.dart';
import 'package:stock_app/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:stock_app/ui/pages/register/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/Login',
      routes: {
        '/': (context) => const HomePage(),
        '/Login': (context) => const Login(),
        '/Register': (context) => const Register(),
        '/Inventory': (context) => const Inventory()
      },
    );
  }
}
