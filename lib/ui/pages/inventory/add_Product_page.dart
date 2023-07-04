import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:stock_app/ui/pages/bussines/bussines.dart';
import 'package:stock_app/ui/pages/inventory/inventory_page.dart';
import 'package:stock_app/ui/widgets/appBar/appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget {
  final Function(
    String? accountId,
    String? code,
    String? name,
    String? description,
    String? stock,
    String? price,
    String? measure,
  )? onSubmitted;

  const AddProduct({this.onSubmitted, Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? base64String;

  Future<void> _CreateProduct() async {
    var url = 'https://stockapi-vmuc.onrender.com/product';
    final headers = {
      'Content-Type': 'application/json',
      'api-key': '\$yntexNicApiKey23',
    };
    int stock1 = int.parse(stock);
    double price1 = double.parse(price);
    var datapost = {
      "accountId": accountId,
      "name": name,
      "code": code,
      "description": description,
      "stock": stock1,
      "price": price1,
      "measure": measure,
      "image": base64String
    };

    var jsonString = jsonEncode(datapost);
    print(jsonString);
    print(code);
    print(name);
    print(description);
    print(stock);
    print(base64String);
    print(price);
    print(measure);
    print(accountId);

    try {
      var response =
          await http.post(Uri.parse(url), body: jsonString, headers: headers);
      if (response.statusCode == 200) {
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

  late String accountId, code, description, name, measure, stock, price;
  String? accountIdError,
      codeError,
      descriptionError,
      nameError,
      measureError,
      stockError,
      priceError;

  String? result;
  Function(
    String? accountId,
    String? code,
    String? name,
    String? description,
    String? stock,
    String? price,
    String? measure,
  )? get onSubmitted => widget.onSubmitted;

  File? img;
  final picker = ImagePicker();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    accountId = '649f6525660a43f2fc857eb3';
    code = '';
    description = '';
    name = '';
    measure = '';
    stock = "";
    price = "";
    img = null;

    accountIdError = null;
    codeError = null;
    descriptionError = null;
    nameError = null;
    measureError = null;
  }

  Future<void> SelImg(op) async {
    var pickedFile;

    if (op == 1) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      if (pickedFile != null) {
        img = File(pickedFile.path);
      } else {
        print("");
      }
      List<int> imageBytes = File(pickedFile!.path).readAsBytesSync();
      base64String = base64Encode(imageBytes);
      print(base64String);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: CustomAppBar(
          title: 'Agregar',
          backgroundColor: ColorsApp.primary,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 15, right: 12, bottom: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      width: 150,
                      height: 150,
                      color: const Color.fromARGB(255, 212, 212, 212),
                      child: img == null
                          ? IconButton(
                              onPressed: () {
                                showImagePickerModal(context);
                              },
                              icon: Icon(Icons.camera_alt,
                                  color: ColorsApp.primary),
                              iconSize: 50,
                            )
                          : IconButton(
                              onPressed: () {
                                showImagePickerModal(context);
                              },
                              icon: Image.file(
                                img!,
                                height: 150,
                                width: 160,
                                fit: BoxFit.cover,
                              )),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 40, bottom: 28, left: 3, right: 15),
                    child: Column(
                      children: [
                        InputField1(
                            labelText: 'Codigo',
                            initialText: '',
                            onChanged: (value) {
                              setState(() {
                                code = value;
                                print(code);
                              });
                            }),
                        SizedBox(height: screenHeight * 0.03),
                        InputField(
                            labelText: 'cantidad',
                            onChanged: (value) {
                              setState(() {
                                stock = value;
                              });
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Padding(
                  padding: EdgeInsets.only(bottom: 5, left: 16, right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InputField(
                          labelText: 'Nombre',
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          }),
                      SizedBox(height: screenHeight * 0.03),
                      InputField(
                          labelText: 'Descripcion',
                          onChanged: (value) {
                            setState(() {
                              description = value;
                            });
                          }),
                      SizedBox(height: screenHeight * 0.03),
                      InputField(
                          labelText: 'precio',
                          onChanged: (value) {
                            setState(() {
                              price = value;
                            });
                          }),
                      SizedBox(height: screenHeight * 0.03),
                      InputField(
                          labelText: 'Unidad de medida',
                          onChanged: (value) {
                            setState(() {
                              measure = value;
                            });
                          }),
                      SizedBox(height: screenHeight * 0.03),
                      FormButton(
                        text: 'Guardar',
                        onPressed: _onButtonPressed,
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }

  void resetErrorText() {
    setState(() {
      codeError = null;
      descriptionError = null;
      nameError = null;
      measureError = null;
    });
  }

  void submit() {
    if (validate()) {
      if (onSubmitted != null) {
        onSubmitted!(accountId, code, name, description, price, stock, measure);
      }
    }
  }

  void _onButtonPressed() {
    // Validación
    if (validate()) {
      // Navegación a otra página
      if (isLoading) {
        _CreateProduct();
        print(code);
        print(name);
        print(description);
        print(stock);
        print(base64String);
        print(price);
        print(measure);
        print(accountId);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Inventory(
                      accountId: accountId,
                    )));
      } else {
        print("zzzzz");
      }
    } else {
      // Mostrar mensaje de error
      print("?");
    }
  }

  bool validate() {
    resetErrorText();

    bool isValid = true;

    if (name.isEmpty) {
      setState(() {
        nameError = 'Nombre Invalido';
      });
      isValid = false;
    }

    if (price == '') {
      setState(() {
        priceError = 'Ingrese un positivo';
      });
      isValid = false;
    }

    if (stock == '') {
      setState(() {
        stockError = 'Por favor,Ingrese un positivo';
      });
      isValid = false;
    }

    return isValid;
  }

  void showImagePickerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 125,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            SelImg(1);
                          },
                          icon: Icon(Icons.add_a_photo_rounded),
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
                          onPressed: () {
                            SelImg(2);
                          },
                          icon: Icon(Icons.add_photo_alternate_rounded),
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
  }

  Future scanBarCode() async {
    String result;

    try {
      result = await FlutterBarcodeScanner.scanBarcode(
          "#fffff", 'Cancelar', true, ScanMode.BARCODE);
    } on PlatformException {
      result = "F";
    }
    if (!mounted) return;
    setState(() => this.result = result);
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

class InputField1 extends StatefulWidget {
  final String? labelText;
  final Function(String)? onChanged;
  final String? initialText;
  final Function(String)? onSubmitted;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autoFocus;
  final bool obscureText;

  const InputField1({
    this.labelText,
    this.onChanged,
    this.onSubmitted,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.autoFocus = false,
    this.obscureText = false,
    this.initialText,
    Key? key,
  }) : super(key: key);

  @override
  _InputField1State createState() => _InputField1State();
}

class _InputField1State extends State<InputField1> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: widget.autoFocus,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.obscureText,
      enabled: true,
      controller: _controller,
      decoration: InputDecoration(
        hoverColor: ColorsApp.primary,
        fillColor: ColorsApp.primary,
        focusColor: ColorsApp.primary,
        labelText: widget.labelText,
        errorText: widget.errorText,
        suffixIcon: IconButton(
          onPressed: () async {
            String barcode = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666',
              'Cancelar',
              true,
              ScanMode.BARCODE,
            );
            setState(() {
              _controller.text = barcode;
            });
          },
          icon: Icon(
            Icons.camera_alt,
            color: ColorsApp.primary,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        iconColor: ColorsApp.primary,
      ),
    );
  }
}
