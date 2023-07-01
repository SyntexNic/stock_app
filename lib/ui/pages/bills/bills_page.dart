import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/Response/Invoices/AccountInvoicesResponse.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/ui/pages/bills/add_bills_page.dart';
import 'package:stock_app/ui/pages/bills/bills_details.dart';

class Bills extends StatefulWidget {
   final String accountId; // ID de la cuenta

  const Bills({super.key,required this.accountId});
  @override
  State<Bills> createState() => _BillsState();
}

final now = DateTime.now(); // Fecha y hora actual
final yesterday = DateTime(now.year, now.month, now.day - 1); // Fecha de ayer


class _BillsState extends State<Bills> {
 // bool isLoading=true;
  List<Result> invoices=[];
  @override 
  void initState() {
    super.initState();
    fetchInvoices();
  }

  Future<void> fetchInvoices() async {
      final url = 'https://stockapi-vmuc.onrender.com/account/${widget.accountId}/invoices';
      final headers ={
        'Content-Type': 'application/json',
        'api-key': '\$yntexNicApiKey23',
      };

      try{
        final response = await http.get(Uri.parse(url), headers: headers);

      if(response.statusCode == 200){
        final jsonresponse = jsonDecode(response.body);
        print(jsonresponse);
        final accountInvoicesResponse = AccountInvoicesResponse.fromJson(jsonresponse);

        setState(() {
          invoices = accountInvoicesResponse.data?.result??[];
          //isLoading=false;
        });
      }else{
        print('Request failed with status: ${response.statusCode}');
      }
      }catch(error){
             print('Error fetching data: $error');
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Facturas"),
          backgroundColor: ColorsApp.primary,
          titleTextStyle: GoogleFonts.getFont('Lato', fontSize: 20),
        ),
        body: invoices.isEmpty?
            Center(
              child: Text("No hay facturas disponibles",
              style: GoogleFonts.getFont(
                'Lato',
                fontSize: 24,
                color: ColorsApp.primary,

              ),),
            )
          : ListView.builder(//Constructor del las facturas
            itemCount: invoices.length,
            itemBuilder: (context,index){
              final invoice = invoices[index];
              final formatter = DateFormat('h:mm a');
              final dateformatter= DateFormat('dd/MM/yyyy');
               final invoiceDateTime =dateformatter.parse(invoice.date!); //Obtén la fecha y hora de la primera factura
               final formattedTime = invoice.invoices![index].time!;
               // Verificar la fecha de la factura
          String dateLabel;
          if (invoiceDateTime.year == now.year &&
              invoiceDateTime.month == now.month &&
              invoiceDateTime.day == now.day) {
            dateLabel = 'Hoy';
          } else if (invoiceDateTime.year == yesterday.year &&
              invoiceDateTime.month == yesterday.month &&
              invoiceDateTime.day == yesterday.day) {
            dateLabel = 'Ayer';
          } else {
            dateLabel = DateFormat('dd/MM/yyyy').format(invoiceDateTime);
          }
      //Mostrar la factura
              return   Column(
        children: [
          const SizedBox(height: 10,),
           if (index == 0 ||
              (index > 0 && invoices[index - 1].date != invoiceDateTime))
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            
              decoration: const BoxDecoration(
                  color: ColorsApp.primary,
                  shape: BoxShape.rectangle,
            borderRadius: BorderRadius.horizontal(
              // Utilizamos el método Radius.elliptical para definir un óvalo alargado horizontalmente
              left: Radius.elliptical(140, 80),
              right: Radius.elliptical(140, 80),
            ),
              ),
              child: Text(dateLabel,
              style: 
              GoogleFonts.getFont(
                'Lato',
                fontSize: 16,
                color: Colors.white
              )       
              ),
            ),
            Container(
               decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ColorsApp.primary,
                    width: 1.0,
                  ),
                ),
              ),
                child: ListTile(
                  title: Text('${invoice.invoices![index].no}',
                  style: GoogleFonts.getFont(
                    'Lato',
                    fontSize: 16
                  )
                  ),
                  subtitle: Text("${formattedTime}",
                  style: GoogleFonts.getFont(
                    'Lato',
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  )
                  ),
                  trailing: Text("\$${invoice.totalAmount}",
                  style: GoogleFonts.getFont(
                    'Lato',
                    fontSize: 24
                  )
                  ),
                  textColor: ColorsApp.primary, 
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> BillDetail()))
                 ),
                ),
                
                
              ]);
            },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorsApp.primary,
          onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>  AddBills())),
         child: const Icon(Icons.add,size: 40,),
        ),
        backgroundColor: ColorsApp.backgroundColor,
    );
  }
}
