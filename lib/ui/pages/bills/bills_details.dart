import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:stock_app/ui/pages/bills/add_bills_page.dart';

class BillDetail extends StatefulWidget {
  const BillDetail({super.key});

  @override
  State<BillDetail> createState() => _BillDetailState();
}

class _BillDetailState extends State<BillDetail> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Detalle de Factura",
      style: GoogleFonts.getFont(
        'Lato',
        fontSize: 20,
        color: ColorsApp.white
        )
      ),
      backgroundColor: ColorsApp.primary,
      ),
      body: Container(
         padding: const EdgeInsets.all(20.0),
        child: DetailsDrawer()),
    );
  }
}