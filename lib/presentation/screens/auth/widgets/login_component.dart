import 'package:flutter/material.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/image_component.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginComponent extends StatefulWidget {
  final void Function(int) onChangeIndex;
  final void Function(String) onChangeEmail;
  final void Function(String) onChangePassword;
  final Future<void> Function() onHandleLogin;

  const LoginComponent({
    super.key,
    required this.onChangeIndex,
    required this.onChangeEmail,
    required this.onChangePassword,
    required this.onHandleLogin,
  });

  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  String email = '';
  String password = '';
  String? emailError;

  // Email validation
  bool validateEmail(String value) {
    final emailRegex =
        RegExp(r'^[^@]+@[^@]+\.[^@]+'); // Simple email validation regex
    return emailRegex.hasMatch(value);
  }

  bool isLoginButtonEnabled() {
    return email.isNotEmpty && password.isNotEmpty && emailError == null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageComponent(),
        const SizedBox(height: 20),
        Text(
          "Login",
          style: textStyles.displayMedium,
        ),
        const SizedBox(height: 20),

        // Email TextField
        TextField(
          onChanged: (value) {
            setState(() {
              email = value;
              emailError =
                  validateEmail(email) ? null : "Invalid email address";
              widget.onChangeEmail(email);
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
            suffixIcon: Icon(Icons.email, color: colors.primary,),
          ),
        ),
        const SizedBox(height: 20),

        // Password TextField
        TextField(
          obscureText: true,
          onChanged: (value) {
            setState(() {
              password = value;
              widget.onChangePassword(password);
            });
          },
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "Password",
            hintText: "Insert your password",
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            hintStyle: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.normal),
            filled: true,
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: Icon(Icons.lock,color: colors.primary,),
          ),
        ),
        const SizedBox(height: 10),

        // Forgot Password Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot password?",
                  style: TextStyle(color: colors.primary),
                ),
              ),
              TextButton(
                onPressed: () {
                  widget.onChangeIndex(1); 
                },
                child: Text(
                  "Don't have an account\nRegister here!",
                  textAlign: TextAlign.center,
                  style: textStyles.bodyLarge?.copyWith(color: colors.primary, ),
                ),
              ),
          ],
        ),
        
        const SizedBox(height: 20),

        // Login Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isLoginButtonEnabled()
                  ? colors.primary
                  : Colors.grey, // Change button color if disabled
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: isLoginButtonEnabled()
                ? () async {
                    await widget.onHandleLogin();
                  }
                : null, // Disable button if conditions are not met
            child:  Text(
              "Login",
              style: textStyles.displaySmall?.copyWith(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    ).animate().moveX(begin: 100, end: 0).fadeIn(duration: 500.ms);
  }
}
