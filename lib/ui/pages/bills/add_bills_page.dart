import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/constants/Theme.dart';
import 'bills_details.dart';
class AddBills extends StatefulWidget {
final  String? no;
  const AddBills({super.key, this.no});

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
        child:  Column(
          children: [
            DetailsDrawer(no: widget.no,),
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

class DetailsDrawer extends StatefulWidget {
  final no;
  const DetailsDrawer({super.key,this.no});

  @override
  State<DetailsDrawer> createState() => _DetailsDrawerState();
}

class _DetailsDrawerState extends State<DetailsDrawer> {
   String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
   TextEditingController controller = TextEditingController();
   TextEditingController controllerN= TextEditingController(); 


   @override 
   void initState() {
    super.initState();
    
    
  } 
  @override
  Widget build(BuildContext context) {
     controller.text=currentDate;
      controllerN.text =widget.no;
      
        return  Column(
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
                              filled: true
                            ), 
                           style: GoogleFonts.getFont('Lato',color: ColorsApp.primary, fontSize: 16
                            , fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
                            controller: controllerN,
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
                            , fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
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
             Column(
               children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                        IcoButton(
                        text: "Borrar Todos",
                        icon: Icons.delete,
                        color: ColorsApp.red,
                        onPressed: (){
                          print("Presionado");
                        }
                        
                        
                        ),
                        IcoButton(
                          text: "Agregar Producto",
                          icon: Icons.add,
                          color: ColorsApp.primary,
                          onPressed: (){
                              showModalBottomSheet(context: context, builder: (BuildContext context){
                                 final double screenHeight = MediaQuery.of(context).size.height;

                                  return  Container(
                                    color: ColorsApp.backgroundColor,
                                    height: 350,
                                    child: Center(
                                      
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20,right: 10,top: 12,bottom:10 ),
                                        child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                          Text(
                                            "Articulo",
                                            style: GoogleFonts.getFont(
                                              'Lato',
                                              color: ColorsApp.primary,
                                              fontSize: 18
                                      
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 350,
                                            child:  TextField(
                                              readOnly: true,
                                              decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(color: ColorsApp.primary)
                                                ),
                                                fillColor: ColorsApp.white,
                                                filled: true
                                      
                                              )
                                      
                                      
                                            ),
                                          ),
                                          Spacer(),
                                          const SaveButton(),
                                         ],
                                        ),
                                      ),
                                    ),
                                  );
                              });
                          }
                          ),
                  ],
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Total:        ‎ ",
                      style: GoogleFonts.getFont(
                        'Lato',
                        fontSize: 24,
                        color: ColorsApp.primary,
                        wordSpacing: 30.0,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                 ),
               ],
             )
          ],
        );
     }
    
  }
  
 

class IcoButton extends StatefulWidget {
  final String? text;
  final IconData? icon; 
  final Color? color; 
   final VoidCallback? onPressed;
  const IcoButton({super.key,this.text, this.icon,required this.color,required this.onPressed});

  @override
  State<IcoButton> createState() => _IcoButtonState();
}

class _IcoButtonState extends State<IcoButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed:widget.onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: widget.color!
        )
      ),
      child: Row(
        children: [
          Text(widget.text?? '',
          style: GoogleFonts.getFont(
            'Lato',
            color:widget.color,
            fontSize: 16
          )
          ),
          const SizedBox(width: 3,),
           Icon(
           widget.icon,
           color: widget.color,
          ),
          
        ],
        
      ),
    );
  }
}




