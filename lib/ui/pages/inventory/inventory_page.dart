import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/constants/Theme.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});
  @override
  State<Inventory> createState() => _InventoryState();
}

final List<Product> Products = [
  Product(number: '001', time: DateTime(2020, 6, 20, 10, 15), amount: '150'),
  Product(number: '002', time: DateTime(2023, 6, 21, 11, 00), amount: '200'),
  Product(number: '003', time: DateTime(2023, 6, 22, 9, 30), amount: '100'),
  Product(number: '004', time: DateTime(2023, 6, 22, 17, 54), amount: '200'),
  // Agrega más facturas según tus necesidades
];

final now = DateTime.now(); // Fecha y hora actual
final yesterday = DateTime(now.year, now.month, now.day - 1); // Fecha de ayer

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: ColorsApp.primary,
      title: Container(
          margin: EdgeInsets.only(left: 70),
          child: Text('Inventario',
              style: GoogleFonts.getFont(
                'Lato',
              ))),
    ));
  }
}

class Product {
  final String number;
  final DateTime time;
  final String amount;

  Product({
    required this.number,
    required this.time,
    required this.amount,
  });
}
