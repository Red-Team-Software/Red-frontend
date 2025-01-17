import 'package:GoDeli/config/constants/enviroments.dart';
import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/common/application/bloc/select_datasource_bloc_bloc.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/search/application/bloc/bloc.dart';
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
  Color _primaryColor = Colors.red; // Define _primaryColor

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
    final dataSourceBloc = context.watch<SelectDatasourceBloc>();

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
            suffixIcon: Icon(
              Icons.email,
              color: colors.primary,
            ),
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
            suffixIcon: Icon(
              Icons.lock,
              color: colors.primary,
            ),
          ),
        ),
        const SizedBox(height: 30),
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
            child: Text(
              "Login",
              style: textStyles.displaySmall?.copyWith(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 20),
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
                style: textStyles.bodyLarge?.copyWith(
                  color: colors.primary,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Login Button
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Switch team`", style: textStyles.displayMedium),
              Switch(

               value: dataSourceBloc.state.isRed ? false : true,
                onChanged: (value) {
                  setState(() {
                    _primaryColor = value ? Colors.blue : Colors.red;
                    // Change the primary color of the app
                    Theme.of(context).copyWith(
                      colorScheme: Theme.of(context)
                          .colorScheme
                          .copyWith(primary: _primaryColor),
                    );
                    // Change environment variables based on switch value
                    if (value) {
                      dataSourceBloc.add(const SelectDatasource(isRed: false));
                      // final apiUrl = Environment.getApiUrl();
                      // getIt<IHttpService>().updateBaseUrl(apiUrl);
                    } else {
                      dataSourceBloc.add(const SelectDatasource(isRed: true));
                      // final apiUrl = Environment.getApiUrl();
                      // context.read<IHttpService>().updateBaseUrl(apiUrl);
                    }
                  });
                },
                activeColor: const Color(0xFF2000B1),
                inactiveThumbColor: const Color(0xFFAD0101),
                
              ),
            ],
          ),
        ),
      ],
    ).animate().moveX(begin: 100, end: 0).fadeIn(duration: 500.ms);
  }
}
