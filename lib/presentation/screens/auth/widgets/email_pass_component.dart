import 'package:flutter/material.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/image_component.dart';

class EmailPassComponent extends StatelessWidget {
  final void Function(int) onChangeIndex;

  const EmailPassComponent({super.key, required this.onChangeIndex});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

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
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "Email",
            hintText: "Insert your email",
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            hintStyle:
                TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
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
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "Password",
            hintText: "Insert your password",
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            hintStyle:
                TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
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
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "Confirm Password",
            hintText: "Insert your password again",
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            hintStyle:
                TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
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
            onPressed: () {

              onChangeIndex(2); // Cambiar a la pantalla de login

              // Implementar lógica de registro
            },
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
            onPressed: (){

              onChangeIndex(0); // Cambiar a la pantalla de login

            }, // Cambiar a la pantalla de login
            child: Text(
              "Login",
              style: TextStyle(fontSize: 18, color: colors.primary),
            ),
          ),
        ),
      ],
    );
  }
}