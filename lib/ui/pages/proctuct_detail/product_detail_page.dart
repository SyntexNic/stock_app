import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/constants/Theme.dart';

class PDetails extends StatefulWidget {
  const PDetails({super.key});

  @override
  State<PDetails> createState() => _PDetailsState();
}

class _PDetailsState extends State<PDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsApp.primary,
          title: Container(
              margin: const EdgeInsets.only(left: 70),
              child: Text(
                'Detalles',
                style: GoogleFonts.getFont(
                  'Lato',
                ),
              )),
        ),
        body: Column(
          children: [],
        ));
  }
}
