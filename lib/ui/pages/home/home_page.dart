import 'package:flutter/material.dart';
import 'package:stock_app/ui/widgets/navbar/navbar.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Navbar(),
        appBar: AppBar(
          title: Container(
            margin: EdgeInsets.only(left: 80),
            child: Text('Home',
                style: GoogleFonts.getFont(
                  'Lato',
                )),
          ),
          elevation: 0,
          backgroundColor: ColorsApp.primary,
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Container(
          color: ColorsApp.primary,
          width: 400,
          height: 150,
          child: Center(
            child: Text(
              "Edumishi",
              style: GoogleFonts.getFont(
                      'Lato',
                      fontSize: 24,
                      color: ColorsApp.white,
                    ),
            ),
          ),
        ));
  }
}
