import 'package:flutter/material.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

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
              accountName: Text('nombre',
                  style: GoogleFonts.getFont(
                    'Lato',
                    color: ColorsApp.white,
                  )),
              accountEmail: Text('correo',
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
            onTap: () => print('Upload tapped'),
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
            onTap: () => Navigator.pushNamed(context, '/Inventory'),
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
            onTap: () => print('Upload tapped'),
          ),
        ],
      ),
    );
  }
}
