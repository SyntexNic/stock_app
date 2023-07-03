import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/Response/Invoices/InvoiceResponse.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:http/http.dart' as http;

class BillDetail extends StatefulWidget {
  final String id;
  const BillDetail({super.key, required this.id});
  
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
        child: DetailsDrawer(id: widget.id,)),
    );
  }
}
//Contenedor de los productos de la factura 
class DetailsContainer extends StatelessWidget {
  final List<InvoiceDetail>? invoiceDetails;
  const DetailsContainer({super.key,this.invoiceDetails});
  
  @override
  Widget build(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height;
   
      return Container(
          padding: const EdgeInsets.all(20.0),
          height: screenHeight*0.45,
          decoration: BoxDecoration(
             color: ColorsApp.white,
            border: Border.all(
              color: ColorsApp.black,
              width: 0.3
            
            ),
              borderRadius: BorderRadius.circular(8),
          ),
          
          child: ListView.builder(
            itemCount: invoiceDetails?.length?? 0,
            itemBuilder: (context,index){
              final detail= invoiceDetails![index];
              final product = detail.product;
              final quantity = detail.quantity ?? 0;
              final subtotal= detail.subTotal ?? 0;
              final price = int.tryParse(product?.price ?? '0') ?? 0;
                final subtotal1 = quantity * price;

              return Column(
                children: [
                  ListTile(
                      title: Text(product?.name?? '',
                      style: GoogleFonts.getFont(
                              'Lato',
                              fontSize: 16,
                              color: ColorsApp.primary,
                              fontWeight: FontWeight.bold
                            )
                            
                            ),
                      subtitle: Text("$quantity x ${product?.price ?? '0'}",
                        style:GoogleFonts.getFont(
                              'Lato',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ColorsApp.primary
                            ),
                      ),
                      trailing: Text(
                        "\$${subtotal1}",
                        style: GoogleFonts.getFont(
                              'Lato',
                              fontSize: 16,
                              color: ColorsApp.primary,
                              fontWeight: FontWeight.bold
                            ),
                      ),
                      
                  ),
                  const Divider(
                      color: ColorsApp.primary,
                      thickness: 1.0,
                  ),
                ],
              );

            },
          ),
          
    
      );
  }
}
// Dibujado de lo que esta en la factura 
class DetailsDrawer extends StatefulWidget {
  final String id;
  const DetailsDrawer({super.key,required this.id});

  @override
  State<DetailsDrawer> createState() => _DetailsDrawerState();
}

class _DetailsDrawerState extends State<DetailsDrawer> {
   String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
   TextEditingController controller = TextEditingController();
   TextEditingController controllerN= TextEditingController();
   Result? invoiceData; 


   @override 
   void initState() {
    super.initState();
    fetchInvoiceData();    
    
  }

  Future<void> fetchInvoiceData() async {
    final url= 'https://stockapi-vmuc.onrender.com/invoice/${widget.id}';
    final headers={
        'Content-Type': 'application/json',
        'api-key': '\$yntexNicApiKey23',
    };
    try {
      final response = await http.get(Uri.parse(url),headers: headers);
      if(mounted){
           if(response.statusCode == 200){
        final jsonData =  jsonDecode(response.body);
        setState(() {
          invoiceData = Result.fromJson(jsonData['data']['result']);

        });
      }else{
        // Manejar el error de la solicitud
        print('Error en la solicitud: ${response.statusCode}');
      }

      }
     
    }catch(e){
      print("Error de conexion: $e");
    }

  }
  @override
  Widget build(BuildContext context) {
    String formattedDate = '';
  if (invoiceData != null && invoiceData!.date != null) {
  final DateTime date = DateTime.parse(invoiceData!.date!);
  final DateFormat formatter = DateFormat('dd/MM/yy');
  formattedDate = formatter.format(date);
}
     controller.text=formattedDate;
     controllerN.text = invoiceData?.no??'';
     if(invoiceData == null){
      return const Center(
        child: CircularProgressIndicator(),
      );
     }else{
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
             DetailsContainer(invoiceDetails: invoiceData?.invoiceDetail),
             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Total: \$${invoiceData?.total}",
                  style: GoogleFonts.getFont(
                    'Lato',
                    fontSize: 24,
                    color: ColorsApp.primary,
                    wordSpacing: 30.0,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
             )
          ],
        );
     }
    
  }
}