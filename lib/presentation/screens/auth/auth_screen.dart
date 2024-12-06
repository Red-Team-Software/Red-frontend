import 'dart:convert';
import 'dart:io';

import 'package:GoDeli/features/auth/application/bloc/auth_bloc.dart';
import 'package:GoDeli/features/user/domain/dto/add_direction_dto.dart';
import 'package:GoDeli/presentation/screens/Cart/cart_screen.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/direction_component.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/email_pass_component.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/login_component.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/profile_component.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const String name = 'auth_page';
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.pushReplacement('/');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is UnAuthenticated || state is AuthError) {
            return _buildAuthScreen(context);
          }
            return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildAuthScreen(BuildContext context) {
    Future<String> convertFileToBase64(File imageFile) async {
      // Leer los bytes del archivo
      final bytes = await imageFile.readAsBytes();
      
      // Convertir los bytes a una cadena base64
      return base64Encode(bytes);
    }
    
    void onChangeIndex(int newIndex) {
      setState(() {
        _isMovingRight = newIndex > _currentIndex;
        _currentIndex = newIndex;
      });
    }

    Future<void> handleLogin() async {
      context.read<AuthBloc>().add(LoginEvent(email, password));
    }

    Future<void> handleRegister() async {
      final realPhone = '$phoneCode$phone';
      final addressDto = AddUserDirectionListDto(
                            directions: [
                              AddUserDirectionDto(
                                name: addressName,
                                favorite: true,
                                lat: selectedLocation!.latitude,
                                lng: selectedLocation!.longitude,
                              ),
                            ],
                          );
      context.read<AuthBloc>().add(
            RegisterEvent(
              email: email,
              password: password,
              fullName: fullname,
              phoneNumber: realPhone,
              address: addressDto,
              image: selectedImage != null ? await convertFileToBase64(selectedImage!) : null,
            ),
          );
    }

    final screens = [
      LoginComponent(
        onChangeIndex: onChangeIndex,
        onHandleLogin: handleLogin,
        onChangeEmail: (value) {
          email = value;
        },
        onChangePassword: (password) => this.password = password,
      ),
      EmailPassComponent(
        onChangeIndex: onChangeIndex,
        onChangeEmail: (email) => this.email = email,
        onChangePassword: (password) => this.password = password,
      ),
      ProfileComponent(
        onChangeIndex: onChangeIndex,
        onChangeImage: (image) => selectedImage = image,
        onChangeFullname: (fullname) => this.fullname = fullname,
        onChangePhoneCode: (phoneCode) => this.phoneCode = phoneCode,
        onChangePhone: (phone) => this.phone = phone,
      ),
      DirectionComponent(
        onChangeIndex: onChangeIndex,
        onFinished: handleRegister,
        onChangeLocation: (location) => selectedLocation = location,
        onChangeAddressName: (addressName) => this.addressName = addressName,
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(child: screens[_currentIndex]),
      ),
    );
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