import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/auth/application/bloc/auth_bloc.dart';
import 'package:GoDeli/features/user/application/bloc/user_bloc.dart';
import 'package:GoDeli/features/user/domain/dto/add_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/delete_update_user_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/update_user_dto.dart';
import 'package:GoDeli/features/user/domain/user.dart';
import 'package:GoDeli/features/user/domain/user_direction.dart';
import 'package:GoDeli/presentation/screens/profile/widgets/addess_modal.dart';
import 'package:GoDeli/presentation/screens/profile/widgets/profile_address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class ProfileScreen extends StatelessWidget {
  static const String name = 'profile_page';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserBloc>(),
      child: BlocListener<UserBloc, UserState>(
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
        child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          if (state is UserLoading) {
            // Show a loading indicator while the state is UserLoading
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserSuccess) {
            // Display the profile screen if the state is UserSuccess
            final user = state.user;
            return _ProfileScreen(
              user: user,
            );
          } else {
            // Display a generic error screen if the state is unrecognized
            return const Center(child: Text("Unexpected state"));
          }
        }),
      ),
    );
  }
}

class _ProfileScreen extends StatefulWidget {
  final User user;

  _ProfileScreen({required this.user, Key? key}) : super(key: key);

  @override
  State<_ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<_ProfileScreen> {
  late bool _readOnly = true;

  final nameTextController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  void initializeControllers() {
    nameTextController.text = widget.user.fullName;
    emailController.text = widget.user.email;
    phoneController.text = widget.user.phone;
    passwordController.text = '********';
    confirmPasswordController.text = '********';
  }

  UpdateUserDto _buildUpdateUserDto(User user) {
    return UpdateUserDto(
      name: nameTextController.text != user.fullName
          ? nameTextController.text
          : null,
      email: emailController.text != user.email ? emailController.text : null,
      phone: phoneController.text != user.phone ? phoneController.text : null,
      password: passwordController.text != '********'
          ? passwordController.text
          : null,
    );
  }

  DeleteUpdateUserDirectionListDto _buildDeleteUserDirectionDto(
      UserDirection direction,{ String? newName, LatLng? newLocation}) {
    
    newName ??= direction.addressName;
    newLocation ??= LatLng(direction.latitude.toDouble(), direction.longitude.toDouble());
    
    return DeleteUpdateUserDirectionListDto(
      directions: [
        DeleteUpdateUserDirectionDto(
          id: direction.id,
          name: newName,
          favorite: direction.isFavorite,
          lat: newLocation.latitude.toDouble(),
          lng: newLocation.longitude.toDouble(),
        ),
      ],
    );
  }

  AddUserDirectionListDto _buildAddUserDirectionDto(
      LatLng location, String name) {
    return AddUserDirectionListDto(
      directions: [
        AddUserDirectionDto(
          name: name,
          favorite: false,
          lat: location.latitude,
          lng: location.longitude,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeControllers();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Keep everything centered
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: widget.user.image != null
                      ? Image.network(widget.user.image!)
                      : Icon(Icons.person, size: 50, color: Colors.grey[700]),
                ),
                const SizedBox(height: 10),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _readOnly = !_readOnly;
                      initializeControllers();
                    });
                  },
                  icon: Icon(_readOnly ? Icons.edit : Icons.cancel,
                      color: Colors.grey),
                  label: Text(_readOnly ? 'Edit' : 'Cancel',
                      style: const TextStyle(color: Colors.grey)),
                ),
                const SizedBox(height: 10),
                Text(
                  'Hello, ${widget.user.fullName}!',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                    context.push('/auth');
                  },
                  child: const Text('Log out',
                      style: TextStyle(color: Colors.red)),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment:
                      Alignment.centerLeft, // Align the titles to the left
                  child: const Text('User:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                CustomTextField(
                  label: 'Email',
                  controller: emailController,
                  readOnly: _readOnly,
                ),
                CustomTextField(
                  label: 'Password',
                  controller: passwordController,
                  isPassword: true,
                  readOnly: _readOnly,
                ),
                if (!_readOnly) // Show only when not read-only
                  CustomTextField(
                    label: 'Confirm Password',
                    controller: confirmPasswordController,
                    isPassword: true,
                    readOnly: _readOnly,
                  ),
                const SizedBox(height: 20),
                Align(
                  alignment:
                      Alignment.centerLeft, // Align the titles to the left
                  child: const Text('Profile:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                CustomTextField(
                  label: 'Full Name',
                  controller: nameTextController,
                  readOnly: _readOnly,
                ),
                CustomTextField(
                  label: 'Phone Number',
                  controller: phoneController,
                  readOnly: _readOnly,
                ),
                if (!_readOnly) const SizedBox(height: 20),
                if (!_readOnly)
                  ElevatedButton(
                    onPressed: () {
                      final updateUserDto = _buildUpdateUserDto(widget.user);
                      context
                          .read<UserBloc>()
                          .add(UpdateUserEvent(updateUserDto: updateUserDto));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    child: const Text('Update Profile',
                        style: TextStyle(fontSize: 16)),
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment:
                          Alignment.centerLeft, // Align the titles to the left
                      child: const Text('Addresses:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.red, size: 30),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return AddressModal(
                              onFinished: (location, name, isUpdate) async {
                                Navigator.pop(context);
                                  // Add the address
                                  final addDirectionDto =
                                      _buildAddUserDirectionDto(location, name);
                                  this.context.read<UserBloc>().add(
                                      AddUserDirectionEvent(
                                          userDirection: addDirectionDto));
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.user.directions.length,
                  itemBuilder: (context, index) {
                    final direction = widget.user.directions[index];

                    return Slidable(
                        endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.25,
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  final dto = _buildDeleteUserDirectionDto(direction);
                                  context
                                      .read<UserBloc>()
                                      .add(DeleteUserDirectionEvent(
                                          userDirection: dto));
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                            ]),
                        child: ProfileAddressCard(
                          addressName: direction.addressName,
                          latitude: direction.latitude.toDouble(),
                          longitude: direction.longitude.toDouble(),
                          isFavorite: direction.isFavorite,
                          id: direction.id,
                          onFavoriteChanged: (id, isFavorite) async {
                            print('Favorite changed');
                          },
                          onUpdate: (){
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return AddressModal(
                                  initialAddressName: direction.addressName,
                                  initialLocation: LatLng(direction.latitude.toDouble(), direction.longitude.toDouble()),
                                  onFinished: (location, name, isUpdate) async {
                                    Navigator.pop(context);
                                      // Add the address
                                      final updateUserDto = _buildDeleteUserDirectionDto(direction, newName: name, newLocation: location);
                                      this.context.read<UserBloc>().add(UpdateUserDirectionEvent(userDirection: updateUserDto));
                                  },
                                );
                              },
                            );
                          },
                        ));
                  },
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
  final TextEditingController controller;
  final bool isPassword;
  final bool readOnly;
  final String? errorText;
  final void Function(String)? onChanged;

  const CustomTextField({
    required this.label,
    required this.controller,
    this.isPassword = false,
    required this.readOnly,
    this.errorText,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        readOnly: readOnly,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          hintText: "Insert your $label",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          errorText: errorText,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          hintStyle: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.normal),
          filled: true,
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: readOnly
              ? null
              : isPassword
                  ? const Icon(Icons.lock)
                  : const Icon(Icons.edit),
        ),
      ),
    );
  }
}
