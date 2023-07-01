import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/constants/Theme.dart';
import 'bills_details.dart';
class AddBills extends StatefulWidget {
  const AddBills({super.key});

  @override
  State<AddBills> createState() => _AddBillsState();
}

class _AddBillsState extends State<AddBills> {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: const Text("Facturacion"),
        backgroundColor: ColorsApp.primary,
        titleTextStyle: GoogleFonts.getFont('Lato', fontSize: 20),
        ),
      backgroundColor: ColorsApp.backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: const Column(
          children: [
             Spacer(),
             SaveButton(),
          ],
        ),
        
      ),
    );
  }
}


class SaveButton extends StatelessWidget {

  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: ()=>print("Presionado"),
        style: ElevatedButton.styleFrom(
          fixedSize: const  Size.fromWidth(350),
          minimumSize: const Size.fromHeight(60),
          backgroundColor: ColorsApp.primary,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
    
        ),
        child: Text(
          "Guardar",
          style: GoogleFonts.getFont("Lato", fontSize: 24, fontWeight: FontWeight.bold),
        
        ),
      ),
    );
  }
}


