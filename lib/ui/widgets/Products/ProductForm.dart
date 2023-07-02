import 'package:flutter/material.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:stock_app/ui/pages/register/register_page.dart';

class ProductForm extends StatelessWidget {
  const ProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
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
                      const EdgeInsets.only(left: 12, right: 12, bottom: 8),
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
                                  padding: const EdgeInsets.only(top: 20),
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
                                              icon: Icon(
                                                  Icons.add_a_photo_rounded),
                                              color: ColorsApp.primary,
                                              iconSize: 35,
                                            ),
                                            Text("Camara"),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons
                                                  .add_photo_alternate_rounded),
                                              color: ColorsApp.primary,
                                              iconSize: 35,
                                            ),
                                            Text("Galeria"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.camera_alt, color: ColorsApp.primary),
                      iconSize: 50,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 28, left: 3, right: 15),
                  child: Column(
                    children: [
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
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
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
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              children: [
                FormButton(
                  text: 'Guardar',
                  onPressed: () {
                    Navigator.pushNamed(context, '/Inventory');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
