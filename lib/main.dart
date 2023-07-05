import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_app/ui/pages/bussines/bussines.dart';
import 'package:stock_app/ui/pages/inventory/add_Product_page.dart';
import 'package:stock_app/ui/pages/inventory/edit_product_page.dart';
import 'package:stock_app/ui/pages/home/home_page.dart';
import 'package:stock_app/ui/pages/inventory/inventory_page.dart';
import 'package:stock_app/ui/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:stock_app/ui/pages/inventory/product_detail_page.dart';
import 'package:stock_app/ui/pages/register/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? userId = await getUserId();

  runApp(MyApp(userId: userId));
}

class MyApp extends StatelessWidget {
  final String? userId;

  MyApp({required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => userId != null ? HomePage(userId: userId!) : Login(),
        '/Login': (context) => const Login(),
        '/Register': (context) => const Register(),
        '/Inventory': (context) => Inventory(accountId: userId!),
        '/AddProduct': (context) => AddProduct(accountId: userId!),
        '/DetailsProduct': (context) => const PDetails(),
        '/EditProduct': (context) => const EditProduct(),
        '/empresa': (context) => const Bussines(),
      },
    );
  }
}

Future<void> saveUserId(String userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_id', userId);
}

// Función para recuperar el ID de usuario de shared_preferences
Future<String?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_id');
}
