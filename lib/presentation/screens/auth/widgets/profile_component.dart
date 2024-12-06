import 'package:GoDeli/presentation/screens/auth/widgets/image_component.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileComponent extends StatefulWidget {
  final void Function(int) onChangeIndex;
  final void Function(File) onChangeImage;
  final void Function(String) onChangeFullname;
  final void Function(String) onChangePhoneCode;
  final void Function(String) onChangePhone;

  const ProfileComponent({
    super.key, 
    required this.onChangeIndex,
    required this.onChangeImage,
    required this.onChangeFullname,
    required this.onChangePhoneCode,
    required this.onChangePhone,
  });

  @override
  State<ProfileComponent> createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent> {
  File? _selectedImage; // Variable para almacenar la imagen seleccionada
  String selectedPhoneCode = '0414'; // Valor inicial del Dropdown
  String fullname = '';
  String phone = '';
  
  String? fullnameError;
  String? phoneError;

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

  bool validateFullname(String value) {
    final hasNoNumbers = !RegExp(r'[0-9]').hasMatch(value);
    return value.length > 2 && hasNoNumbers;
  }

  bool validatePhone(String value) {
    final isNumeric = RegExp(r'^\d+$').hasMatch(value);
    return value.length == 7 && isNumeric;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    bool isNextButtonEnabled() {
      return fullname.isNotEmpty &&
          phone.isNotEmpty &&
          fullnameError == null &&
          phoneError == null;
    }

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
              radius: 80,
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
          onChanged: (value) {
            setState(() {
              fullname = value;
              fullnameError = validateFullname(value)
                  ? null
                  : "Fullname must have more than 2 letters and no numbers";
            });
          },
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "Fullname",
            hintText: "Insert your Fullname",
            errorText: fullnameError,
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
                value: selectedPhoneCode, // Valor inicial
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedPhoneCode = newValue;
                    });
                  }
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
                onChanged: (value) {
                  setState(() {
                    phone = value;
                    setState(() {
                      phoneError = validatePhone(phone)
                          ? null
                          : "Phone must be numeric and 7 digits";
                    });
                  });
                },
                maxLength: 7,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "Phone",
                  hintText: "Insert your phone number",
                  errorText: phoneError,
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
            onPressed: isNextButtonEnabled()
                ? () {
                    if( _selectedImage != null){
                      widget.onChangeImage(_selectedImage!);
                    }
                    widget.onChangeFullname(fullname);
                    widget.onChangePhoneCode(selectedPhoneCode);
                    widget.onChangePhone(phone);
                    widget.onChangeIndex(3);
                  }
                : null,
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
