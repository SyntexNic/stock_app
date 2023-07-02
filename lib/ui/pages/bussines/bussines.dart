import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:stock_app/ui/pages/home/home_page.dart';
import 'package:stock_app/ui/pages/inventory/add_Product_page.dart';
import 'package:stock_app/ui/pages/login/login_page.dart';
import 'package:stock_app/ui/widgets/appBar/appbar.dart';

class Bussines extends StatefulWidget {
    final Function(String? email, String? password)? onSubmitted;

  const Bussines({Key? key, this.onSubmitted}):super(key: key);

  @override
  State<Bussines> createState() => _BussinesState();
}

class _BussinesState extends State<Bussines> {
  late String name, measure;
  String? emailError, passwordError;
  Function(String? name, String? measure)? get onSubmitted =>
      widget.onSubmitted;

  @override
  void initState() {
    super.initState();
    name = '';
    measure = '';

    emailError = null;
    passwordError = null;
  }

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    bool isValid = true;
    if (name.isEmpty) {
      setState(() {
        emailError = 'Correo Invalido';
      });
      isValid = false;
    }

    if (measure.isEmpty) {
      setState(() {
        passwordError = 'Por favor Ingrese una contraseña';
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
              Text('Iniciar Sesion',
                  style: GoogleFonts.getFont(
                    'Lato',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: screenHeight * .01),
              SizedBox(height: screenHeight * .07),
              InputField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                labelText: 'Nombre de la empresa',
                errorText: emailError,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autoFocus: true,
              ),
              SizedBox(height: screenHeight * .025),
              InputField(
                onChanged: (value) {
                  setState(() {
                    measure = value;
                  });
                },
                onSubmitted: (val) => submit(),
                labelText: 'Contraseña',
                errorText: passwordError,
                obscureText: true,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: screenHeight * .075,
              ),
              FormButton(
                text: 'Log In',
                onPressed: _onButtonPressed,
                //onpressed: submit,
                /* Esto valida si los datos enviados son correctos, estan desactivados pa mientras */

                //onPressed: submit,
              ),
              SizedBox(
                height: screenHeight * .01,
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/Register'),
                child: RichText(
                  text: TextSpan(
                    text: "¿No tienes cuenta?",
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: ColorsApp.black,
                    ),
                    children: [
                      TextSpan(
                          text: 'Crea un aquí',
                          style: GoogleFonts.getFont(
                            'Lato',
                            color: ColorsApp.primary,
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onButtonPressed() {
    // Validación
    if (validate()) {
      // Navegación a otra página
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
            content: Text('Los datos no son válidos.'),
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
