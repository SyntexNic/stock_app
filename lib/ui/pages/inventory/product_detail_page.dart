import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/Response/Products/AccountProductsResponse.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:stock_app/ui/pages/inventory/inventory_page.dart';
import 'package:http/http.dart' as http;

class PDetails extends StatefulWidget {
  const PDetails({super.key});

  @override
  State<PDetails> createState() => _PDetailsState();
}

class _PDetailsState extends State<PDetails> {
  late String id;
  late String AccountId;
  bool isLoading = true;

  Future<void> deleteProduct() async {
    final url = 'https://stockapi-vmuc.onrender.com/product/$id';
    final headers = {
      'Content-Type': 'application/json',
      'api-key': '\$yntexNicApiKey23',
    };

    try {
      final response = await http.delete(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
          print('Recurso eliminado correctamente');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Inventory(
                      accountId: '${AccountId}',
                    )),
          );
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

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
          children: [
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 5,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 12, right: 12, bottom: 8),
                          child: Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color.fromARGB(255, 212, 212, 212),
                              ),
                              child: data['img'] == null
                                  ? IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.camera_alt,
                                          color: ColorsApp.primary),
                                      iconSize: 50,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          30), // El valor de 75 puede ajustarse según tus necesidades
                                      child: Image.memory(
                                        data['img']!,
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                        )),
                    Expanded(
                        flex: 5,
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 30, bottom: 28, left: 3, right: 15),
                            child: Container(
                                padding: const EdgeInsets.all(.26),
                                height: screenHeight * 0.25,
                                decoration: BoxDecoration(
                                  color: ColorsApp.white,
                                  border: Border.all(
                                      color: ColorsApp.black, width: 0.3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text("Codigo: ",
                                          style: GoogleFonts.getFont('Lato',
                                              fontSize: 16,
                                              color: ColorsApp.primary,
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text(
                                        "${data['code']}",
                                        style: GoogleFonts.getFont('Lato',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: ColorsApp.primary),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("Cantidad: ",
                                          style: GoogleFonts.getFont('Lato',
                                              fontSize: 16,
                                              color: ColorsApp.primary,
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text(
                                        "${data['stock']}",
                                        style: GoogleFonts.getFont('Lato',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: ColorsApp.primary),
                                      ),
                                    ),
                                  ],
                                ))))
                  ],
                )),
            Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              top: 5, bottom: 20, left: 16, right: 16),
                          child: Container(
                              padding: const EdgeInsets.all(15.0),
                              height: screenHeight * 0.45,
                              decoration: BoxDecoration(
                                color: ColorsApp.white,
                                border: Border.all(
                                    color: ColorsApp.black, width: 0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text("Nombre: ",
                                        style: GoogleFonts.getFont('Lato',
                                            fontSize: 16,
                                            color: ColorsApp.primary,
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Text(
                                      "${data['nombre']}",
                                      style: GoogleFonts.getFont('Lato',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsApp.primary),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("Descripcion: ",
                                        style: GoogleFonts.getFont('Lato',
                                            fontSize: 16,
                                            color: ColorsApp.primary,
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Text(
                                      "${data['desc']}",
                                      style: GoogleFonts.getFont('Lato',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsApp.primary),
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight * .13,
                                  ),
                                  const Divider(
                                    color: ColorsApp.primary,
                                    thickness: 1.0,
                                  ),
                                  ListTile(
                                    title: Text("Precio: ",
                                        style: GoogleFonts.getFont('Lato',
                                            fontSize: 16,
                                            color: ColorsApp.primary,
                                            fontWeight: FontWeight.bold)),
                                    trailing: Text(
                                      "${data['price']}",
                                      style: GoogleFonts.getFont('Lato',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsApp.primary),
                                    ),
                                  ),
                                ],
                              ))),
                    ],
                  )),
                )),
            Expanded(
                flex: 1,
                child: Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FormButton(
                          text: 'Editar',
                          onPressed: () {
                            Navigator.pushNamed(context, '/EditProduct');
                          },
                        ),
                        FormButton1(
                          text: 'Borrar',
                          onPressed: () {
                            id = data['id'];
                            AccountId = data['AccountId'];
                            deleteProduct();
                          },
                        )
                      ],
                    )))
          ],
        ));
  }
}

class FormButton extends StatelessWidget {
  final String text;
  final Function? onPressed;

  const FormButton({this.text = '', this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        fixedSize: Size.fromWidth(150),
        backgroundColor: ColorsApp.primary,
        padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

class FormButton1 extends StatelessWidget {
  final String text;
  final Function? onPressed;

  const FormButton1({this.text = '', this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        fixedSize: Size.fromWidth(150),
        backgroundColor: ColorsApp.red,
        padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
