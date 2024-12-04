import 'dart:io';

import 'package:GoDeli/features/auth/application/bloc/auth_bloc.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/direction_component.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/email_pass_component.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/login_component.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/profile_component.dart';
import 'package:GoDeli/presentation/screens/profile/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:latlong2/latlong.dart';


class AuthScreen extends StatelessWidget {
  static const String name = 'auth_screen';
  const AuthScreen({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const AuthScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthView(),
    );
  }
}

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {

  
  int _currentIndex = 0; // Inicialmente mostrar el LoginComponent
  bool _isMovingRight = true;

  // Email and password
  String email = '';
  String password = '';

  // Profile
  File? selectedImage;
  String fullname = '';
  String phoneCode = '';
  String phone = '';

  // Direction
  LatLng? selectedLocation;
  String addressName = '';

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = context.watch<AuthBloc>();

    void _onChangeIndex(int newIndex) {
      setState(() {
        _isMovingRight = newIndex >
            _currentIndex; // Verifica si se está moviendo a la derecha
        _currentIndex = newIndex; // Cambia al nuevo índice
      });
    }

    Future<void> _handleLogin() async {
      print("Logging in with:");
      print("Email: $email");
      print("Password: $password");
      // Aquí puedes añadir la lógica para hacer una petición al backend
      authBloc.add(LoginEvent(email, password));

    }


    Future<void> _handleRegister() async {
      // Simulación del registro
      print('Registering user...');
      print('Email: $email');
      print('Password: $password');
      print('Image: ${selectedImage?.path}');
      print('Fullname: $fullname');
      print('Phone: $phoneCode $phone');
      print('Location: $selectedLocation');
      print('Address Name: $addressName');
      // Aquí puedes integrar la lógica de la API para registrar al usuario.
    }

    final screens = [
      LoginComponent(
        onChangeIndex: _onChangeIndex, // Cambiar al índice de registro
        onHandleLogin: _handleLogin,
        onChangeEmail: (value) {
          email = value;
          print('Texto que no aparece');
        },
        onChangePassword: (password) => this.password = password,
      ),
      EmailPassComponent(
          onChangeIndex: _onChangeIndex, // Cambiar al índice de login
          onChangeEmail: (email) => this.email = email,
          onChangePassword: (password) =>
              {this.password = password, print(this.password)}),
      ProfileComponent(
          onChangeIndex: _onChangeIndex, // Cambiar al índice de login
          onChangeImage: (image) => this.selectedImage = image,
          onChangeFullname: (fullname) => this.fullname = fullname,
          onChangePhoneCode: (phoneCode) => this.phoneCode = phoneCode,
          onChangePhone: (phone) => this.phone = phone),
      DirectionComponent(
        onChangeIndex: _onChangeIndex,
        onFinished: _handleRegister,
        onChangeLocation: (location) => selectedLocation = location as LatLng,
        onChangeAddressName: (addressName) => addressName = addressName,
      )
    ];

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(child: screens[_currentIndex]),
    ));
  }
}

//? Animaciones
// Center(
// child: AnimatedSwitcher(
//             duration: const Duration(milliseconds: 500),
//             transitionBuilder: (child, animation) {
//               return _isMovingRight
//                   ? SlideInRight(child: child) // Animación al deslizarse hacia la derecha
//                   : SlideInLeft(child: child); // Animación al deslizarse hacia la izquierda
//             },
//             child:
//                 screens[_currentIndex], // Renderiza el widget actual/ Mostrar el componente según el índice
//         ),
//       ),