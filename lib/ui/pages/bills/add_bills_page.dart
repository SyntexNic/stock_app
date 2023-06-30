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
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller.text=currentDate;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Facturacion"),
        backgroundColor: ColorsApp.primary,
        titleTextStyle: GoogleFonts.getFont('Lato', fontSize: 20),
        ),
      backgroundColor: ColorsApp.backgroundColor,
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ 
                      Text(
                        "N° Factura",
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
                           
                            height: 50,
                           child: TextField(
                            enabled: false,
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
                ),
                const SizedBox(width: 50,),
                Expanded(
                  child: Column(
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
                            height: 50,
                           child: TextField(
                             enabled: false,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorsApp.primary)
                              ),
                              fillColor: ColorsApp.white,
                              filled: true,
                            ),
                            style: GoogleFonts.getFont('Lato',color: ColorsApp.primary, fontSize: 16
                            , fontStyle: FontStyle.italic),
                            controller: controller
                            
                          ),
                         )
                    ],
                  ),
                ),
              ],
            ),
           const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    "Articulos",
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: ColorsApp.primary,
                      fontSize: 18
                    ),
                ),
              ],
            ),
            DetailsContainer(),
           const Spacer(),
            const SaveButton(),
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

class DetailsContainer extends StatelessWidget {
  const DetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height;
    return ClipRRect(
        borderRadius: BorderRadius.circular(8),
      child: Container(
          color: ColorsApp.white,
          padding: EdgeInsets.all(20.0),
          height: screenHeight*0.45,
          
    
      ),
    );
  }
}
