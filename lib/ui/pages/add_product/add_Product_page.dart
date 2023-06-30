import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:stock_app/ui/pages/register/register_page.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsApp.primary,
          title: Container(
              margin: const EdgeInsets.only(left: 70),
              child: Text(
                'Agregar',
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
                                labelText: 'precio',
                              ),
                              SizedBox(height: screenHeight * .030),
                              InputField(
                                labelText: 'cantidad',
                              )
                            ],
                          ),
                        ))
                  ],
                )),
            Expanded(
                flex: 4,
                child: Container(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 5, bottom: 20, left: 16, right: 16),
                          child: Column(
                            children: [
                              InputField(
                                labelText: 'precio',
                              ),
                              SizedBox(height: screenHeight * .030),
                              InputField(
                                labelText: 'cantidad',
                              ),
                              SizedBox(height: screenHeight * .030),
                              InputField(
                                labelText: 'precio',
                              ),
                              SizedBox(height: screenHeight * .030),
                              InputField(
                                labelText: 'cantidad',
                              ),
                              SizedBox(height: screenHeight * .030),
                              InputField(
                                labelText: 'precio',
                              ),
                              SizedBox(height: screenHeight * .030),
                              InputField(
                                labelText: 'cantidad',
                              ),
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
                    child: Column(
                      children: [
                        FormButton(
                          text: 'Agregar',
                          onPressed: () {
                            Navigator.pushNamed(context, '/Inventory');
                          },
                          //onpressed: submit,
                          /* Esto valida si los datos enviados son correctos, estan desactivados pa mientras */

                          //onPressed: submit,
                        ),
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
        fixedSize: Size.fromWidth(350),
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
