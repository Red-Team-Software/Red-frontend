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
import 'package:GoDeli/presentation/screens/profile/widgets/wallet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class ProfileScreen extends StatelessWidget {
  static const String name = 'profile_page';

  const ProfileScreen({super.key});

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

  const _ProfileScreen({required this.user, super.key});

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
      UserDirection direction) {
    return DeleteUpdateUserDirectionListDto(
      directions: [
        DeleteUpdateUserDirectionDto(
          id: direction.id,
          name: direction.addressName,
          favorite: direction.isFavorite,
          lat: direction.latitude.toDouble(),
          lng: direction.longitude.toDouble(),
        ),
      ],
    );
  }

  DeleteUpdateUserDirectionListDto _buildUpdateUserDirectionDto(
      {required UserDirection direction,
      String? newName,
      LatLng? newLocation,
      required List<UserDirection> directions}) {
    newName ??= direction.addressName;
    newLocation ??=
        LatLng(direction.latitude.toDouble(), direction.longitude.toDouble());

    final newDto = DeleteUpdateUserDirectionDto(
      id: direction.id,
      name: newName,
      favorite: direction.isFavorite,
      lat: newLocation.latitude.toDouble(),
      lng: newLocation.longitude.toDouble(),
    );

    final dtoList = directions
        .map((e) => DeleteUpdateUserDirectionDto(
              id: e.id,
              name: e.addressName,
              favorite: e.isFavorite,
              lat: e.latitude.toDouble(),
              lng: e.longitude.toDouble(),
            ))
        .toList();

    dtoList.removeWhere((element) => element.id == direction.id);
    dtoList.add(newDto);

    return DeleteUpdateUserDirectionListDto(
      directions: dtoList,
    );
  }

  DeleteUpdateUserDirectionListDto _buildUpdateFavoriteUserDirectionDto(
      {required UserDirection newFavoriteDirection,
      required List<UserDirection> directions}) {
    for (var element in directions) {
      if (element.isFavorite) {
        element.isFavorite = false;
      }
    }

    for (var element in directions) {
      if (element.id == newFavoriteDirection.id) {
        element.isFavorite = true;
      }
    }

    final dtoList = directions
        .map((e) => DeleteUpdateUserDirectionDto(
              id: e.id,
              name: e.addressName,
              favorite: e.isFavorite,
              lat: e.latitude.toDouble(),
              lng: e.longitude.toDouble(),
            ))
        .toList();

    return DeleteUpdateUserDirectionListDto(
      directions: dtoList,
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

    final theme = Theme.of(context);

    final scales = theme.textTheme;

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
                Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[300],
                          child: widget.user.image != null
                              ? Image.network(widget.user.image!)
                              : Icon(Icons.person,
                                  size: 50, color: Colors.grey[700]),
                        )
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          'Hello, ${widget.user.fullName}!',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
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
                            const SizedBox(width: 20),
                            TextButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(LogoutEvent());
                                context.push('/auth');
                              },
                              child: Text('Log out',
                                  style: TextStyle(color: theme.primaryColor, fontSize: scales.bodyMedium?.fontSize, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                WalletCard(wallet: widget.user.wallet,),
                Align(
                  alignment:
                      Alignment.centerLeft, // Align the titles to the left
                  child: Text('User:',
                      style:
                          TextStyle(fontSize: scales.bodyLarge?.fontSize, fontWeight: FontWeight.bold)),
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
                const Align(
                  alignment:
                      Alignment.centerLeft, // Align the titles to the left
                  child: Text('Profile:',
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
                    const Align(
                      alignment:
                          Alignment.centerLeft, // Align the titles to the left
                      child: Text('Addresses:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    IconButton(
                      icon:
                          Icon(Icons.add, color: theme.primaryColor, size: 30),
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
                                  final dto =
                                      _buildDeleteUserDirectionDto(direction);
                                  context.read<UserBloc>().add(
                                      DeleteUserDirectionEvent(
                                          userDirection: dto));
                                },
                                backgroundColor: theme.primaryColor,
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
                          address: direction.address,
                          onFavoriteChanged: (id, isFavorite) async {
                            if (direction.isFavorite) {
                              return;
                            }
                            final updateUserDto =
                                _buildUpdateFavoriteUserDirectionDto(
                                    newFavoriteDirection: direction,
                                    directions: widget.user.directions);
                            this.context.read<UserBloc>().add(
                                UpdateUserDirectionEvent(
                                    userDirection: updateUserDto));
                          },
                          onUpdate: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return AddressModal(
                                  initialAddressName: direction.addressName,
                                  initialLocation: LatLng(
                                      direction.latitude.toDouble(),
                                      direction.longitude.toDouble()),
                                  initialLocationName: direction.address,
                                  onFinished: (location, name, isUpdate) async {
                                    Navigator.pop(context);
                                    // update the address
                                    final updateUserDto =
                                        _buildUpdateUserDirectionDto(
                                            direction: direction,
                                            newName: name,
                                            newLocation: location,
                                            directions: widget.user.directions);
                                    this.context.read<UserBloc>().add(
                                        UpdateUserDirectionEvent(
                                            userDirection: updateUserDto));
                                  },
                                );
                              },
                            );
                          },
                        )).animate();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms);
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
    super.key,
  });

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
