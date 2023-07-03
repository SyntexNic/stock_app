import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:stock_app/ui/pages/bussines/bussines.dart';
import 'package:stock_app/ui/widgets/appBar/appbar.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  final Function(String? email, String? password, String? name)? onSubmitted;

  const AddProduct({this.onSubmitted, Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late String email, password, confirmPassword, name;
  String? emailError, passwordError, nameError;

  String? result;
  Function(String? email, String? password, String? name)? get onSubmitted =>
      widget.onSubmitted;
  File? img = null;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    email = '';
    password = '';
    confirmPassword = '';
    name = '';

    emailError = null;
    passwordError = null;
    nameError = null;
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
                          : Image.file(
                              img!,
                              height: 150,
                              width: 160,
                              fit: BoxFit.cover,
                            ),
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
                          initialText: 'Ejemplo',
                          onChanged: (value) {
                            result == null ? '' : '$result';
                          },
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        InputField(
                          labelText: 'cantidad',
                        ),
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
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      InputField(
                        labelText: 'Descripcion',
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      InputField(
                        labelText: 'precio',
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      InputField(
                        labelText: 'Unidad de medida',
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      FormButton(
                        text: 'Guardar',
                        onPressed: () {
                          Navigator.pushNamed(context, '/Inventory');
                        },
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
      nameError = null;
    });
  }

  void submit() {
    if (validate()) {
      if (onSubmitted != null) {
        onSubmitted!(email, password, name);
      }
    }
  }

  bool validate() {
    resetErrorText();

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;
    // hay que corregir esa vaina comentada xd
    if (email.isEmpty /*|| !emailExp.hasMatch(email)*/) {
      setState(() {
        emailError = 'Correo Invalido';
      });
      isValid = false;
    }

    if (name.isEmpty) {
      setState(() {
        emailError = 'Ingrese un Nombre';
      });
      isValid = false;
    }

    if (password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        passwordError = 'Por favor,Ingrese una contraseña';
      });
      isValid = false;
    }
    if (password != confirmPassword) {
      setState(() {
        passwordError = 'Contraseñas no coinciden';
      });
      isValid = false;
    }

    return isValid;
  }

  void _onButtonPressed() {
    // Validación
    if (validate()) {
      // Navegación a otra página
      final data = {
        'nombre': name,
        'email': email,
        'password': password,
      };
      Navigator.pushNamed(context, '/empresa', arguments: data);
    } else {
      // Mostrar mensaje de error
      print("");
    }
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

class InputField1 extends StatelessWidget {
  final String? labelText;
  final Function(String)? onChanged;
  final String? initialText; // Nueva propiedad para el texto inicial

  final Function(String)? onSubmitted;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autoFocus;
  final bool obscureText;
  const InputField1(
      {this.labelText,
      this.onChanged,
      this.onSubmitted,
      this.errorText,
      this.keyboardType,
      this.textInputAction,
      this.autoFocus = false,
      this.obscureText = false,
      this.initialText,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController(text: '');

    return TextField(
      autofocus: autoFocus,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      controller:
          _controller, // Establecemos el controlador con el texto inicial

      decoration: InputDecoration(
          hoverColor: ColorsApp.primary,
          fillColor: ColorsApp.primary,
          focusColor: ColorsApp.primary,
          labelText: labelText,
          errorText: errorText,
          suffixIcon: IconButton(
              onPressed: () async {
                String barcode = await FlutterBarcodeScanner.scanBarcode(
                  '#ff6666', // Color personalizado para el escáner
                  'Cancelar', // Texto del botón de cancelar
                  true, // Mostrar flash
                  ScanMode.BARCODE, // Modo de escaneo
                );
                _controller.text = barcode;

                print(
                    'Código de barras escaneado: $barcode-----------------------------------------------------------------------------------------------------');
              },
              icon: Icon(
                Icons.camera_alt,
                color: ColorsApp.primary,
              )),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          iconColor: ColorsApp.primary),
    );
  }
}
