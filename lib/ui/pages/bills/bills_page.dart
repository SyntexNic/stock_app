import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/ui/pages/bills/add_bills_page.dart';

class Bills extends StatefulWidget {
  const Bills({super.key});
  @override
  State<Bills> createState() => _BillsState();
}
final List<Invoice> invoices = [
    Invoice(number: '001', time: DateTime(2020, 6, 20, 10, 15), amount: '150'),
    Invoice(number: '002', time:  DateTime(2023, 6, 21, 11,00), amount: '200'),
    Invoice(number: '003', time:  DateTime(2023, 6, 22, 9, 30), amount: '100'),
    Invoice(number: '004', time:  DateTime(2023, 6, 22, 17,54), amount: '200'),
    // Agrega más facturas según tus necesidades
  ];

final now = DateTime.now(); // Fecha y hora actual
final yesterday = DateTime(now.year, now.month, now.day - 1); // Fecha de ayer


class _BillsState extends State<Bills> {
  @override
  Widget build(BuildContext context) {
      invoices.sort((a, b) => b.time.compareTo(a.time));
    return Scaffold(
        appBar: AppBar(
          title: const Text("Facturas"),
          backgroundColor: ColorsApp.primary,
          titleTextStyle: GoogleFonts.getFont('Lato', fontSize: 20),
        ),
        body: ListView.builder(//Constructor del las facturas
            itemCount: invoices.length,
            itemBuilder: (context,index){
              final formatter = DateFormat('h:mm a');
               final invoiceDateTime = invoices[index].time; //Obtén la fecha y hora de la primera factura
               final formattedTime = formatter.format(invoiceDateTime);
              final invoice = invoices[index];
               // Verificar la fecha de la factura
      String dateLabel;
      if (invoice.time.year == now.year &&
          invoice.time.month == now.month &&
          invoice.time.day == now.day) {
        dateLabel = 'Hoy';
      } else if (invoice.time.year == yesterday.year &&
          invoice.time.month == yesterday.month &&
          invoice.time.day == yesterday.day) {
        dateLabel = 'Ayer';
      } else {
        dateLabel = DateFormat('dd/MM/yyyy').format(invoice.time);
      }
      //Mostrar la factura
              return   Column(
        children: [
          const SizedBox(height: 10,),
           if (index == 0 ||
              (index > 0 && 
                  invoices[index - 1].time.day !=
                      invoice.time.day))
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
                  title: Text('${invoice.number}',
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
                  trailing: Text("\$${invoice.amount}",
                  style: GoogleFonts.getFont(
                    'Lato',
                    fontSize: 24
                  )
                  ),
                  textColor: ColorsApp.primary, 
                 ),
                ),
                
                
              ]);
            },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorsApp.primary,
          onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> AddBills())),
         child: const Icon(Icons.add,size: 40,),
        ),
        backgroundColor: ColorsApp.backgroundColor,
    );
  }
}


class Invoice {
  final String number;
  final DateTime time;
  final String amount;

  Invoice({
    required this.number,
    required this.time,
    required this.amount,
  });
}
