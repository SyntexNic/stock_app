import 'package:stock_app/ui/pages/register/register_page.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  /// Callback for when this form is submitted successfully. Parameters are (email, password)
  final Function(String? email, String? password)? onSubmitted;

  const Login({this.onSubmitted, Key? key}) : super(key: key);
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  late String email, password;
  String? emailError, passwordError;
  Function(String? email, String? password)? get onSubmitted =>
      widget.onSubmitted;

  @override
  void initState() {
    super.initState();
    email = '';
    password = '';

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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: screenHeight * .12),
            const Text(
              'Iniciar Sesion',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * .01),
            SizedBox(height: screenHeight * .12),
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
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Olvidaste tu contraseña?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * .075,
            ),
            FormButton(
              text: 'Log In',
              onPressed: submit,
            ),
            SizedBox(
              height: screenHeight * .15,
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Register(),
                ),
              ),
              child: RichText(
                text: const TextSpan(
                  text: "¿No tienes cuenta?",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Crea un aquí',
                      style: TextStyle(
                        color: Color.fromARGB(255, 4, 30, 71),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
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
        labelText: labelText,
        errorText: errorText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
