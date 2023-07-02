import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stock_app/Response/Login/AccountResponse.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool isLoading = true;
  Result? account;
  @override
  void initState() {
    super.initState();
    fetchAccount();
  }

  Future<void> fetchAccount() async {
    final url =
        'https://stockapi-vmuc.onrender.com/account/64968cb6367264fca92b90d6';
    final headers = {
      'Content-Type': 'application/json',
      'api-key': '\$yntexNicApiKey23',
    };
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonresponse = jsonDecode(response.body);
        final loginResponse = CreateAccountResponse.fromJson(jsonresponse);

        setState(() {
          account = loginResponse.data?.result;
          //account = loginResponse.data?.result;
          //AccountId = account?.accountId;

          isLoading = false;
          print('Request gg with status: ${response.statusCode}');

          print('${account}');
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  //https://stockapi-vmuc.onrender.com/account/<cuenta_id>
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      backgroundColor: ColorsApp.primary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Center(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ColorsApp.white,
                    ),
                  )
                : UserAccountsDrawerHeader(
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
