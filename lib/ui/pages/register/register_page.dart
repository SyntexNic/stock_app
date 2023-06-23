import 'package:flutter/material.dart';


class Register extends StatefulWidget {
  /// Callback for when this form is submitted successfully. Parameters are (email, password)
  final Function(String? email, String? password, String? name)? onSubmitted;

  const Register({this.onSubmitted, Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String email, password, confirmPassword,name;
  String? emailError, passwordError,nameError;
  Function(String? email, String? password, String? name)? get onSubmitted =>
      widget.onSubmitted;

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

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
      nameError = null;
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

  void submit() {
    if (validate()) {
      if (onSubmitted != null) {
        onSubmitted!(email, password,name);
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
              'Crear Cuenta',
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
              labelText: 'Nombre',
              errorText: nameError,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              autoFocus: true,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onChanged: (value) {
                setState(() {
                  name = value;
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
              labelText: 'Contraseña',
              errorText: passwordError,
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onChanged: (value) {
                setState(() {
                  confirmPassword = value;
                });
              },
              onSubmitted: (value) => submit(),
              labelText: 'Confirmar Contraseña',
              errorText: passwordError,
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: screenHeight * .075,
            ),
            FormButton(
              text: 'Crear Cuenta',
              onPressed: submit,
            ),
            SizedBox(
              height: screenHeight * .125,
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: RichText(
                text: const TextSpan(
                  text: "Ya tienes una cuenta? ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Inicia Sesion',
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
