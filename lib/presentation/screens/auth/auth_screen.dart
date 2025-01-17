import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:GoDeli/features/auth/application/bloc/auth_bloc.dart';
import 'package:GoDeli/features/user/domain/dto/add_direction_dto.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/direction_component.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/email_pass_component.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/login_component.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/profile_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
  String direction = '';

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
    final colors = Theme.of(context).colorScheme;

    Future<Uint8List?> compressFile(String file) async {
      return await FlutterImageCompress.compressWithFile(
        file,
        minWidth: 300,
        minHeight: 300,
        quality: 80,
      );
    }

    Future<String> converToBase64(Uint8List bytes) async {
      return base64Encode(bytes);
    }

    void onChangeIndex(int newIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
    }

    Future<void> handleLogin() async {
      context.read<AuthBloc>().add(LoginEvent(email, password));
    }

    Future<void> handleRegister() async {
      final realPhone = '58$phoneCode$phone';
      String? image;
      if (selectedImage != null) {
        final compressedImage = await compressFile(selectedImage!.path);
        image = compressedImage != null
            ? await converToBase64(compressedImage)
            : null;
      } else {
        image = null;
      }
      final addressDto = AddUserDirectionDto(
        name: addressName,
        direction: direction,
        favorite: true,
        lat: selectedLocation!.latitude,
        lng: selectedLocation!.longitude,
      );
      context.read<AuthBloc>().add(
            RegisterEvent(
                email: email,
                password: password,
                fullName: fullname,
                phoneNumber: realPhone,
                address: addressDto,
                image: image),
          );
      onChangeIndex(1);
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
        onChangeDirection: (direction) => this.direction = direction,
      ),
    ];

    return Scaffold(
      body: Stack(children: [
        if(_currentIndex > 0) Positioned(
              top: 40,
              left: 5,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: colors.primary),
                onPressed: () {
                  onChangeIndex(
                      _currentIndex - 1); // Cambiar a la pantalla de login
                },
              ),
            ).animate().fadeIn(),
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child:Center(
            child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  bottom: MediaQuery.of(context).viewInsets.bottom +
                      20.0, // Ajuste para el teclado
                ),
                child: screens[_currentIndex]),
          ).animate().moveY(begin: 100, end: 0).fadeIn(duration: 500.ms),
      ),
        ]),
    );
  }
}
