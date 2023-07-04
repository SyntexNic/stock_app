
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/Response/Invoices/InvoiceResponse.dart' as invoice;
import 'package:stock_app/models/invoices.dart' as invoicescreate;
import 'package:stock_app/constants/Theme.dart';
import 'package:stock_app/ui/pages/bills/products/products_list.dart';
import 'bills_details.dart';
import 'package:http/http.dart' as http;
class AddBills extends StatefulWidget {
final String? id;
final  String? no;
  const AddBills({super.key, this.no,this.id});

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
            DetailsDrawer(no: widget.no,id: widget.id,),
             
          ],
        ),
        
      ),
    );
  }
}
 

class SaveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const SaveButton({super.key,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: onPressed,
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
  final String? id;
   final List<invoice.InvoiceDetail>? invoiceDetails;
  const DetailsDrawer({super.key,this.no,this.id,this.invoiceDetails});

  @override
  State<DetailsDrawer> createState() => _DetailsDrawerState();
}

class _DetailsDrawerState extends State<DetailsDrawer> {
   String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
   TextEditingController controller = TextEditingController();
   TextEditingController controllerN= TextEditingController(); 
   TextEditingController controllerProduct= TextEditingController();
   TextEditingController controllerQuantity =TextEditingController();
   TextEditingController controllerPrice = TextEditingController();
    List<invoice.InvoiceDetail> invoiceDetails = [];
    List<invoicescreate.InvoiceDetail> createDetails = [];
     dynamic total=0;
     dynamic idProducto;
     int maxstock=0;
      int quantity =0;
      int subtotal=0;
    String? quantityErrorMessage;
     bool isnew =false; 
  
 
    void resetErrorText() {
    setState(() {
      quantityErrorMessage=null;
    });
  }
   Future<void> saveInvoice() async {
    final  date = (DateTime.now()).toIso8601String();
    final url = Uri.parse('https://stockapi-vmuc.onrender.com/invoice');
    final headers = {
      'Content-Type': 'application/json',
      'api-key': '\$yntexNicApiKey23',
    };

      final invoiceData = {
    'accountId': widget.id,
    'date': date,
    'invoiceDetail': createDetails.map((detail) {
      return {
        'product': {
          'id':detail.product.productId,
          'name': detail.product.name,
          'price': detail.product.price,
        },
        'quantity': detail.quantity,
        'subTotal': detail.subtotal,
      };
    }).toList(),
    'total': total,
    
  };
   var jsonstring= jsonEncode(invoiceData);
  print(jsonstring);
    try {
      var response =
          await http.post(url, body: jsonstring, headers: headers);
      if (response.statusCode == 200 || response.statusCode==201) {
        //final jsonresponse = jsonDecode(response.body);
        setState(() {
          print('Request gg with status: ${response.statusCode}');
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
    
  }

  
  void addProduct(invoice.Product selectedProduct, int quantity, invoicescreate.Product invoiceProduct) {
    subtotal = int.parse(selectedProduct.price!) * quantity;
    total+=subtotal;
    final invoiceDetail = invoice.InvoiceDetail( 
      product: selectedProduct,
      quantity: quantity,
      subTotal: subtotal,
    );
    final createInvoiceDetail = invoicescreate.InvoiceDetail(
      product: invoiceProduct,
       quantity: quantity, 
       subtotal: subtotal
      );

    setState(() {
      invoiceDetails.add(invoiceDetail);
      createDetails.add(createInvoiceDetail);
      controllerProduct.text = '';
      controllerPrice.text = '';
      controllerQuantity.text = '';
    });
  }


   @override 
   void initState() {
    super.initState();
    quantityErrorMessage=null;
    isnew=false;
    
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
                                borderSide: BorderSide(color: ColorsApp.primary),
                                 borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                borderSide: BorderSide(color: ColorsApp.primary),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              fillColor: ColorsApp.white,
                              filled: true,
                            ),
                            style: GoogleFonts.getFont('Lato',color: ColorsApp.primary, fontSize: 16
                            , fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                            controller: controller
                            
                          ),
                         ),
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
             DetailsContainer(invoiceDetails: invoiceDetails,),
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
                          if (invoiceDetails.isNotEmpty) {
                              setState(() {
                                invoiceDetails.clear();
                                total = 0;
                              });
                            }
                        }
                        
                        
                        ),
                        //Boton de agregar productos
                        IcoButton(
                          text: "Agregar Producto",
                          icon: Icons.add,
                          color: ColorsApp.primary,
                          onPressed: (){
                              showModalBottomSheet(context: context, builder: (BuildContext context){
                                 
                        
                                  return  Container(
                                    color: ColorsApp.backgroundColor,
                                    height: 300,
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
                                      SizedBox(
                                        width: 350,
                                        child:  TextField(
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(color: ColorsApp.primary),
                                             borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            fillColor: ColorsApp.white,
                                            filled: true
                                  
                                          ),
                                  
                                          onTap:() async{
                                                 final result = await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => Inventory(accountId: widget.id!)),
                                                  );
                                                  if(result!= null){
                                                    
                                                    controllerProduct.text = result['nombre'];
                                                    controllerPrice.text = result['price'].toString(); 
                                                    maxstock = result['stock']; 
                                                    idProducto = result['id'];
                                                    
                                                    }
                        
                                          },
                                          controller: controllerProduct,
                                          
                                          
                                  
                                        ),
                                      ),
                                        Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 10),
                                                Text(
                                                    "Cantidad",
                                                    style: GoogleFonts.getFont(
                                                      'Lato',
                                                      color: ColorsApp.primary,
                                                      fontSize: 18,
                                                    ),
                                                ),
                                               SizedBox(
                                                    height: 50,
                                                    child:  TextField(
                                                      readOnly: false,
                                                      keyboardType: TextInputType.number,
                                                      decoration:  InputDecoration(
                                                      border: const OutlineInputBorder(
                                                        borderSide: BorderSide(color: ColorsApp.primary),
                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                        ),
                                                        fillColor: ColorsApp.white,
                                                        filled: true,
                                                        errorText: quantityErrorMessage,
                                                      ),
                                              
                                                      controller: controllerQuantity,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10,),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                 const SizedBox(height: 10),
                                                Text(
                                                    "Precio",
                                                    style: GoogleFonts.getFont(
                                                      'Lato',
                                                      color: ColorsApp.primary,
                                                      fontSize: 18,
                                                    ),
                                                ),
                                               SizedBox(
                                                    height: 50,
                                                    child:  TextField(
                                                      readOnly: true,
                                                      keyboardType: TextInputType.number,
                                                      decoration: const InputDecoration(
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(color: ColorsApp.primary),
                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                        ),
                                                        fillColor: ColorsApp.white,
                                                        filled: true
                                              
                                                      ),
                                                      controller: controllerPrice,
                                              
                                              
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          )
                        
                                        ],
                                      ),
                                      Spacer(),
                                      SaveButton(onPressed: () {
                                        if(controllerQuantity!= null){
                                             quantity = int.parse(controllerQuantity.text);
                                         if (quantity > maxstock) {
                                           setState(() {
                                                  quantityErrorMessage = "No hay suficiente stock ";
                                                });
                                         }
                                         else  if (quantity <= 0) {
                                          setState(() {
                                            quantityErrorMessage = "La cantidad debe ser mayor a 0";
                                          });
                                        } 
                                       else {
                                          resetErrorText();
                                          final selectedProduct = invoice.Product(
                                            name: controllerProduct.text,
                                            price: controllerPrice.text,
                                          );
                                          final invoiceProduct = invoicescreate.Product(
                                            productId: idProducto, 
                                            name: controllerProduct.text, 
                                            price: double.parse(controllerPrice.text));
                                          addProduct(selectedProduct, quantity,invoiceProduct);
                                          Navigator.pop(context); // Cerrar el modal
                                          } 
                                         }else{
                                          print("Vacio");
                                         }
                                        }
                                        
                                          // Mostrar mensaje de error o hacer algo en),
                                        )
                                    ]),
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
                    Text("Total: ‎ $total ",
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
                
                    SaveButton(
                    onPressed: (){
                      
                      saveInvoice();
                      Navigator.pop(context,true);
                    },  
                  ),         
               ],
             ),
              

          ],);
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
            fontSize: 14
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




