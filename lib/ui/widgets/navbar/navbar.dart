import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_app/Response/Login/AccountResponse.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:stock_app/ui/pages/bills/bills_page.dart';
import 'package:stock_app/ui/pages/bills/products/products_list.dart';
import 'package:stock_app/ui/pages/inventory/add_Product_page.dart';

class Navbar extends StatefulWidget {
  final String userId;
  Navbar({Key? key, required this.userId}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool isLoading = true;
  Result? account;
  @override
  void initState() {
    super.initState();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');

    Navigator.pushReplacementNamed(context, '/Login');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      backgroundColor: ColorsApp.primary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Center(
            child: UserAccountsDrawerHeader(
              margin: const EdgeInsets.only(left: 105),
              accountName: Text('${account?.name}',
                  style: GoogleFonts.getFont(
                    'Lato',
                    color: ColorsApp.white,
                  )),
              accountEmail: Text('${account?.email}',
                  style: GoogleFonts.getFont(
                    'Lato',
                    color: ColorsApp.white,
                  )),
              currentAccountPicture: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 12, 54, 122),
                child: ClipOval(
                  child: Image.asset('images/logo.png'),
                ),
              ),
              decoration: BoxDecoration(color: ColorsApp.primary),
            ),
          ),
          Divider(color: ColorsApp.white),
          ListTile(
            leading: Icon(Icons.receipt_long_outlined, color: ColorsApp.white),
            title: Text('Facturacion',
                style: GoogleFonts.getFont(
                  'Lato',
                  color: ColorsApp.white,
                )),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Bills(
                            accountId: "${widget.userId}",
                          )));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.warehouse_outlined,
              color: ColorsApp.white,
            ),
            title: Text(
              'Inventario',
              style: GoogleFonts.getFont(
                'Lato',
                color: ColorsApp.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Inventory(
                            accountId: "${widget.userId}",
                          )));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.add,
              color: ColorsApp.white,
            ),
            title: Text(
              'Agregar',
              style: GoogleFonts.getFont(
                'Lato',
                color: ColorsApp.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProduct(),
                  ));
            },
          ),
          SizedBox(
            height: screenHeight * .49,
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: ColorsApp.white,
            ),
            title: Text('Desconectarse',
                style: GoogleFonts.getFont(
                  'Lato',
                  color: ColorsApp.white,
                )),
            onTap: logout,
          ),
        ],
      ),
    );
  }
}
