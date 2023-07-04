import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/Response/Products/AccountProductsResponse.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:stock_app/models/products.dart';
import 'package:stock_app/ui/pages/inventory/inventory_page.dart';
import 'package:stock_app/ui/pages/login/login_page.dart';

class PDetails extends StatefulWidget {
  const PDetails({super.key});

  @override
  State<PDetails> createState() => _PDetailsState();
}

class _PDetailsState extends State<PDetails> {
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
                            child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: 125,
                                          child: Center(
                                              child: Padding(
                                            padding: EdgeInsets.only(top: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                    flex: 5,
                                                    child: Column(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(Icons
                                                                .add_a_photo_rounded),
                                                            color: ColorsApp
                                                                .primary,
                                                            iconSize: 35),
                                                        Text("Camara")
                                                      ],
                                                    )),
                                                Expanded(
                                                    flex: 5,
                                                    child: Column(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(Icons
                                                                .add_photo_alternate_rounded),
                                                            color: ColorsApp
                                                                .primary,
                                                            iconSize: 35),
                                                        Text("Galeria")
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          )),
                                        );
                                      });
                                },
                                icon: Icon(Icons.camera_alt,
                                    color: ColorsApp.primary),
                                iconSize: 50),
                          ),
                        )),
                    Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 30, bottom: 28, left: 3, right: 15),
                          child: Column(
                            children: [
                              InputField(
                                labelText: 'codigo: ${data['code']}',
                              ),
                              SizedBox(height: screenHeight * .030),
                              InputField(
                                labelText: 'cantidad${data['stock']}',
                              )
                            ],
                          ),
                        ))
                  ],
                )),
            Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 216, 214, 214),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 5, bottom: 20, left: 16, right: 16),
                          child: Column(
                            children: [
                              Text("Nombre: ${data['nombre']}"),
                              SizedBox(height: screenHeight * .030),
                              Text("Descripcion: ${data['desc']}"),
                              SizedBox(height: screenHeight * .030),
                              Text("precio:${data['price']}"),
                              SizedBox(height: screenHeight * .030),
                            ],
                          ),
                        ),
                      ),
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
                            Navigator.pushNamed(context, '/Inventory');
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
