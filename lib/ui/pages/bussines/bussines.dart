import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:stock_app/ui/pages/home/home_page.dart';
import 'package:stock_app/ui/widgets/appBar/appbar.dart';
import 'package:http/http.dart' as http;

class Bussines extends StatefulWidget {
  final Function(String? email, String? password)? onSubmitted;

  const Bussines({Key? key, this.onSubmitted}) : super(key: key);

  @override
  State<Bussines> createState() => _BussinesState();
}

class _BussinesState extends State<Bussines> {
  late String name, measure;
  String? nameError, measureError;
  Function(String? name, String? measure)? get onSubmitted =>
      widget.onSubmitted;

  @override
  void initState() {
    super.initState();
    name = '';
    measure = '';

    nameError = null;
    measureError = null;
  }

  void resetErrorText() {
    setState(() {
      nameError = null;
      measureError = null;
    });
  }

  bool validate() {
    resetErrorText();

    bool isValid = true;
    if (name.isEmpty) {
      setState(() {
        nameError = 'nombre Invalido';
      });
      isValid = false;
    }

    if (measure.isEmpty) {
      setState(() {
        measureError = 'Por favor Ingrese una dato';
      });
      isValid = false;
    }

    return isValid;
  }

  void submit() {
    if (validate()) {
      if (onSubmitted != null) {
        onSubmitted!(name, measure);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Empresa',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: screenHeight * .05),
              //padding: EdgeInsets.symmetric(horizontal: 50),
              Text('Empresa',
                  style: GoogleFonts.getFont(
                    'Lato',
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: screenHeight * .04),
              InputField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                labelText: 'Nombre de la empresa',
                errorText: nameError,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autoFocus: true,
              ),
              SizedBox(height: screenHeight * .025),
              Text('Configuracion Adicional',
                  style: GoogleFonts.getFont(
                    'Lato',
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: screenHeight * .04),

              InputField(
                onChanged: (value) {
                  setState(() {
                    measure = value;
                  });
                },
                onSubmitted: (val) => submit(),
                labelText: 'Tipo de moneda',
                errorText: measureError,
                obscureText: true,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: screenHeight * .075,
              ),
              FormButton(
                text: 'Siguiente',
                onPressed: _onButtonPressed,
                //onpressed: submit,
                /* Esto valida si los datos enviados son correctos, estan desactivados pa mientras */

                //onPressed: submit,
              ),
              SizedBox(
                height: screenHeight * .01,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> _CreateAccount() async {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    var url = 'https://stockapi-vmuc.onrender.com/account';
    final headers = {
      'Content-Type': 'application/json',
      'api-key': '\$yntexNicApiKey23',
    };

    String? nombre = data['nombre'];
    String? email = data['email'];
    String? password = data['password'];
    print(nombre);
    print(email);
    print(password);

    var datapost = {
      "name": nombre,
      "email": email,
      "pass": password,
      "bussinessName": name,
      "currency": measure,
    };
    var jsonString = jsonEncode(datapost);
    print(jsonString);

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

  void _onButtonPressed() {
    // Validación
    if (validate()) {
      // Navegación a otra página
      _CreateAccount();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Mostrar mensaje de error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('xd'),
            actions: <Widget>[
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
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

class InputField extends StatelessWidget {
  final String? labelText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autoFocus;
  final bool obscureText;
  const InputField(
      {this.labelText,
      this.onChanged,
      this.onSubmitted,
      this.errorText,
      this.keyboardType,
      this.textInputAction,
      this.autoFocus = false,
      this.obscureText = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      decoration: InputDecoration(
          hoverColor: ColorsApp.primary,
          fillColor: ColorsApp.primary,
          focusColor: ColorsApp.primary,
          labelText: labelText,
          errorText: errorText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          iconColor: ColorsApp.primary),
    );
  }
}
