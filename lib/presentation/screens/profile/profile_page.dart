import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/user/application/bloc/user_bloc.dart';
import 'package:GoDeli/features/user/domain/user.dart';
import 'package:GoDeli/presentation/screens/profile/widgets/profile_address_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(ProfileScreen());
}

class ProfileScreen extends StatefulWidget {
  static const String name = 'profile_page';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserBloc>(),
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
            context.push('/');
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            // Mostrar un indicador de carga mientras el estado es UserLoading
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserSuccess) {
            // Mostrar la pantalla del perfil si el estado es UserSuccess
            final user = state.user;
            return _ProfileScreen(
              user: user,
            );
          } else {
            // Mostrar una pantalla de error genérica si el estado no es reconocido
            return const Center(child: Text("Unexpected state"));
          }
        },
      ),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  final User user;
  final bool editable = false;

  const _ProfileScreen({Key? key, required this.user}) : super(key: key);

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
                  backgroundColor:
                      Colors.grey[300], // Coloca aquí la imagen del perfil
                  child: user.image != null
                      ? Image.network(user.image!)
                      : Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.grey[700],
                        ),
                ),
                const SizedBox(height: 10),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, color: Colors.grey),
                  label: const Text('Editar perfil',
                      style: TextStyle(color: Colors.grey)),
                ),
                const SizedBox(height: 10),
                Text(
                  '¡Hola, ${user.fullName}!',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Cerrar Sesión',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Usuario:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                CustomTextField(
                    label: 'Correo', 
                    initialValue: user.email
                ),
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
                CustomTextField(
                    label: 'Nombre', initialValue: 'Cristina Figueira'),
                CustomTextField(
                    label: 'Numero', initialValue: '+58 424 273-3220'),
                SizedBox(height: 20),
                Text(
                  'Direcciones:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ProfileAddressCard(
                    title: 'Mi casa',
                    address: 'San juan',
                    isSelected: true,
                    onSelect: () {}),
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
