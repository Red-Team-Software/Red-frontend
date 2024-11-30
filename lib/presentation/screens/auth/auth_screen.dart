import 'package:GoDeli/presentation/screens/auth/widgets/direction_component.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/email_pass_component.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/login_component.dart';
import 'package:GoDeli/presentation/screens/auth/widgets/profile_component.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    void _onChangeIndex(int newIndex) {
      setState(() {
        _isMovingRight = newIndex >
            _currentIndex; // Verifica si se está moviendo a la derecha
        _currentIndex = newIndex; // Cambia al nuevo índice
      });
    }

    final screens = [
      LoginComponent(
        onChangeIndex: _onChangeIndex // Cambiar al índice de registro
      ),
      EmailPassComponent(
        onChangeIndex: _onChangeIndex // Cambiar al índice de login
      ),
      ProfileComponent(
        onChangeIndex: _onChangeIndex // Cambiar al índice de login
      ),
      DirectionComponent(
        onChangeIndex: _onChangeIndex
      )
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return _isMovingRight
                  ? SlideInRight(child: child) // Animación al deslizarse hacia la derecha
                  : SlideInLeft(child: child); // Animación al deslizarse hacia la izquierda
            },
            child:
                screens[_currentIndex], // Mostrar el componente según el índice
          ),
        ),
      )
    );
  }
}
