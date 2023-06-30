import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:stock_app/ui/pages/login/login_page.dart';

class AddBills extends StatefulWidget {
  const AddBills({super.key});

  @override
  State<AddBills> createState() => _AddBillsState();
}
class _AddBillsState extends State<AddBills> {
  String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Facturacion")),
      backgroundColor: ColorsApp.backgroundColor,
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    Text(
                      "Número de Factura",
                      style: GoogleFonts.getFont(
                        'Lato',
                        color: ColorsApp.primary,
                        fontSize: 18,
                        
                      ),
                    ),
                    const SizedBox(
                      height: 10
                      ),
                       const SizedBox(
                          width: 150,
                          height: 50,
                         child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorsApp.primary)
                            ),
                           fillColor: ColorsApp.white,
                            filled: true
                          ),
                        ),
                       )
                  ],
                ),
                const SizedBox(width: 50,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fecha",
                      style: GoogleFonts.getFont(
                        'Lato',
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10,),
                     SizedBox(
                          width: 150,
                          height: 50,
                         child: TextField(
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorsApp.primary)
                            ),
                            fillColor: ColorsApp.white,
                            filled: true
                          ),
                          style: GoogleFonts.getFont('Lato',color: ColorsApp.primary,),
                          controller: TextEditingController(
                            text: currentDate,
                          
                          ),
                          
                        ),
                       )
                  ],
                ),
              ],
            ),
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
          style: GoogleFonts.getFont("Lato", fontSize: 20),
        
        ),
      ),
    );
  }
}
