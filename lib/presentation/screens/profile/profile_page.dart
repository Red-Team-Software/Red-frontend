import 'package:GoDeli/presentation/screens/profile/widgets/profile_address_profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ProfileScreen());
}

class ProfileScreen extends StatelessWidget {

  static const String name = 'profile_page';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _ProfileScreen(),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_picture.png'), // Coloca aquí la imagen del perfil
                  ),
                  SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.edit, color: Colors.grey),
                    label: Text('Editar perfil', style: TextStyle(color: Colors.grey)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '¡Hola, Cristina!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Cerrar Sesión',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Usuario:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  CustomTextField(label: 'Correo', initialValue: 'cristinafiguera@gmail.com'),
                  CustomTextField(
                    label: 'Contraseña',
                    initialValue: '************',
                    isPassword: true,
                  ),
                  CustomTextField(
                    label: 'Confirmar Contraseña',
                    initialValue: '************',
                    isPassword: true,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Perfil:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  CustomTextField(label: 'Nombre', initialValue: 'Cristina Figueira'),
                  CustomTextField(label: 'Numero', initialValue: '+58 424 273-3220'),
                  SizedBox(height: 20),
                  Text(
                    'Direcciones:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ProfileAddressCard(title: 'Mi casa', address: 'San juan', isSelected: true, onSelect: (){}),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: Text(
                      'Update Profile',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final bool isPassword;

  const CustomTextField({
    required this.label,
    required this.initialValue,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        initialValue: initialValue,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
