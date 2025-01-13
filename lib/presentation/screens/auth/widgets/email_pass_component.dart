import 'package:flutter/material.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/image_component.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EmailPassComponent extends StatefulWidget {
  final void Function(int) onChangeIndex;
  final void Function(String) onChangeEmail;
  final void Function(String) onChangePassword;

  const EmailPassComponent({
    super.key,
    required this.onChangeIndex,
    required this.onChangeEmail,
    required this.onChangePassword,
  });

  @override
  State<EmailPassComponent> createState() => _EmailPassComponentState();
}

class _EmailPassComponentState extends State<EmailPassComponent> {
  String email = '';
  String pass = '';
  String confirmPass = '';

  String? emailError;
  String? passError;
  String? confirmPassError;

  // Controller for Confirm Password field
  final TextEditingController confirmPassController = TextEditingController();

  // Email validation
  bool validateEmail(String value) {
    final emailRegex =
        RegExp(r'^[^@]+@[^@]+\.[^@]+'); // Simple email validation regex
    return emailRegex.hasMatch(value);
  }

  // Password validation
  bool validatePassword(String value) {
    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    final hasLowercase = value.contains(RegExp(r'[a-z]'));
    final hasDigit = value.contains(RegExp(r'\d'));
    return value.length >= 8 && hasUppercase && hasLowercase && hasDigit;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    bool isNextButtonEnabled() {
      return email.isNotEmpty &&
          pass.isNotEmpty &&
          confirmPass.isNotEmpty &&
          emailError == null &&
          passError == null &&
          confirmPassError == null;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageComponent(),
        const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          onChanged: (value) {
            setState(() {
              email = value;
              setState(() {
                emailError =
                    validateEmail(email) ? null : "Please enter a valid email";
              });
            });
          },
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "Email",
            hintText: "Insert your email",
            errorText: emailError,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            hintStyle: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.normal),
            filled: true,
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: const Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          obscureText: true,
          onChanged: (value) {
            setState(() {
              pass = value;
              setState(() {
                passError = validatePassword(pass)
                    ? null
                    : "Password must have at least:\n"
                        "1 uppercase letter, 1 lowercase letter, 1 digit, and 8 characters";
                confirmPass = '';
                confirmPassController.clear();
                confirmPassError = null;
              });
            });
          },
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "Password",
            hintText: "Insert your password",
            errorText: passError,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            hintStyle: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.normal),
            filled: true,
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: const Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          obscureText: true,
          onChanged: (value) {
            setState(() {
              confirmPass = value;
              confirmPassError =
                  confirmPass == pass ? null : "Passwords do not match";
            });
          },
          controller: confirmPassController,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "Confirm Password",
            hintText: "Insert your password again",
            errorText: confirmPassError,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            hintStyle: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.normal),
            filled: true,
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: const Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed:
                //TODO: Activar la confirmacion
                isNextButtonEnabled()
                    ? () {
                        widget.onChangeEmail(email);
                        widget.onChangePassword(pass);
                        widget.onChangeIndex(
                            2); // Cambiar a la siguiente pantalla
                      }
                    : null, // Deshabilitar si los campos están vacíos
            child: const Text(
              "Next",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: colors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              widget.onChangeIndex(0); // Cambiar a la pantalla de login
            },
            child: Text(
              "Login",
              style: TextStyle(fontSize: 18, color: colors.primary),
            ),
          ),
        ),
      ],
    ).animate().moveX(begin: 100, end: 0).fadeIn(duration: 500.ms);
  }
}
