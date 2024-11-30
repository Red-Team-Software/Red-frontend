import 'package:GoDeli/presentation/screens/auth/widgets/image_component.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileComponent extends StatefulWidget {
  final void Function(int) onChangeIndex;

  const ProfileComponent({super.key, required this.onChangeIndex});

  @override
  State<ProfileComponent> createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent> {
  File? _selectedImage; // Variable para almacenar la imagen seleccionada

  final ImagePicker _picker = ImagePicker(); // Instancia de ImagePicker

  Future<void> _pickImage() async {
    // Mostrar opciones para elegir entre cámara o galería
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery, // También puedes usar ImageSource.camera
      imageQuality: 50, // Calidad de la imagen para reducir tamaño
    );

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path); // Guardar la imagen seleccionada
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Uploader de imagen de perfil
        ImageComponent(),
        // Título del formulario
        const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            // Imagen o Placeholder circular
            CircleAvatar(
              radius: 50,
              backgroundImage: _selectedImage != null
                  ? FileImage(_selectedImage!) as ImageProvider
                  : null,
              backgroundColor: Colors.grey[300],
              child: _selectedImage == null
                  ? Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey[700],
                    )
                  : null,
            ),
            // Botón para subir imagen
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: _pickImage, // Llama a la función para seleccionar imagen
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.primary,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "Fullname",
            hintText: "Insert your Fullname",
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            hintStyle: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.normal),
            filled: true,
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 20),
        // Row para Dropdown y Phone TextField
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<String>(
                value: '0414', // Valor inicial
                onChanged: (String? newValue) {
                  // Lógica para manejar el cambio de valor
                },
                items: <String>[
                  '0414',
                  '0424',
                  '0416',
                  '0426',
                  '0412'
                ] // Lista de códigos de teléfono
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                borderRadius: BorderRadius.circular(8),
                // Estilo del dropdown cuando está desplegado
                dropdownColor: Colors.white,
                underline: const SizedBox(),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "Phone",
                  hintText: "Insert your phone number",
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  hintStyle: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.normal),
                  filled: true,
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: const Icon(Icons.phone),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
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
              widget.onChangeIndex(3); // Cambiar a la pantalla de login
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
            onPressed: () {
              widget.onChangeIndex(1); // Cambiar a la pantalla de login
            },
            child: Text(
              "Back",
              style: TextStyle(fontSize: 18, color: colors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
