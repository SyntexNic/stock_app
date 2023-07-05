import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_app/Response/Login/LoginResponse.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:stock_app/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  /// Callback for when this form is submitted successfully. Parameters are (email, password)
  final Function(String? email, String? password)? onSubmitted;

  const Login({this.onSubmitted, Key? key}) : super(key: key);
  @override
  State<Login> createState() => _Login();
}

//https://stockapi-vmuc.onrender.com/account?email=<syntexnic@gmail.com>&pass=<password>

class _Login extends State<Login> {
  late String email, password;
  String? emailError, passwordError;
  Function(String? email, String? password)? get onSubmitted =>
      widget.onSubmitted;

  bool isLoading = true;
  bool pc = false;
  Result? account;
  //String? account;
  String? AccountId = "";

  @override
  void initState() {
    super.initState();
    email = '';
    password = '';

    emailError = null;
    passwordError = null;

    /*if (AccountId == null || AccountId == '') {
      fetchAccount();
    } else {
      _LoadId();
    }*/

    fetchAccount();
  }

  Future<void> fetchAccount() async {
    //SharedPreferences pref = await SharedPreferences.getInstance();

    final url =
        'https://stockapi-vmuc.onrender.com/account?email=$email&pass=$password';
    final headers = {
      'Content-Type': 'application/json',
      'api-key': '\$yntexNicApiKey23',
    };
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonresponse = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(jsonresponse);

        setState(() {
          //account = loginResponse.data?.result ?? [];
          account = loginResponse.data?.result;

          if (account!.credentialsCorrect!) {
            final String? accountId = account?.accountId;
            print(accountId);

            //pref.setString('ID', accountId!);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            print("accountId is null");
          }
          pc = true;
          isLoading = false;
          print('Request gg with status: ${response.statusCode}');
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;
    if (email.isEmpty || !emailExp.hasMatch(email)) {
      setState(() {
        emailError = 'Correo Invalido';
      });
      isValid = false;
    }

    if (password.isEmpty) {
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
        onSubmitted!(email, password);
      }
    }
  }

  _LoadId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      AccountId = pref.getString('ID');
      print(AccountId);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: ColorsApp.primary,
            width: 400,
            height: 190,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("StockUp",
                      style: GoogleFonts.getFont('Lato',
                          color: ColorsApp.white, fontSize: 22)),
                ),
                Center(
                  child: Image.asset('images/icon/icon.png', height: 90),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,

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
                      email = value;
                    });
                  },
                  labelText: 'Correo',
                  errorText: emailError,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autoFocus: true,
                ),
                SizedBox(height: screenHeight * .025),
                InputField(
                  onChanged: (value) {
                    setState(() {
                      password = value;
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
          )
        ],
      ),
    );
  }

  void _onButtonPressed() {
    // Validación
    if (validate()) {
      // Navegación a otra página
      if (isLoading) {
        fetchAccount();
      } else {
        print("zzzzz");
        print(AccountId);
      }
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
