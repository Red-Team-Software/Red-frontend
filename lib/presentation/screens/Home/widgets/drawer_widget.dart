import 'package:GoDeli/features/auth/application/bloc/auth_bloc.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/user/application/bloc/user_bloc.dart';
import 'package:GoDeli/presentation/core/drawer/drawer_items.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DrawerWidget extends StatelessWidget {
  final VoidCallback closeDrawer;

  const DrawerWidget({super.key, required this.closeDrawer});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    final cartBloc = context.watch<CartBloc>();
    final language = context.watch<LanguagesCubit>().state.selected.language;
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          onPressed: closeDrawer,
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {

          if(state is UserSuccess){
            return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TranslationWidget(
                              message: state.user.fullName,
                              toLanguage: language,
                              builder: (translated) => Text(
                                    translated,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16),
                                  )),
                          Text(state.user.phone,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14))
                        ],
                      )
                    ],
                  ),
                ),
                buildDrawerItems(context),
              ],
            ),
          );
          }
            return Center(child: CircularProgressIndicator( color: colors.secondary,));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          authBloc.add(LogoutEvent());
          cartBloc.add(ClearCart());
          context.push('/auth');
        },
        backgroundColor: Colors.white,
        label: TranslationWidget(
          message: 'Logout',
          toLanguage: language,
          builder: (translated) => Text(translated,
              style: textStyles.displaySmall?.copyWith(color: colors.primary),
          ),
        ),
        icon: Icon(Icons.logout, color: colors.primary,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Widget buildDrawerItems(BuildContext context) => Column(
        children: DrawerItems.all
            .map((item) => ListTile(
                  enableFeedback: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  leading: Icon(
                    item.icon,
                    color: Colors.white,
                  ),
                  title: TranslationWidget(
                    message: item.title,
                    toLanguage:
                        context.watch<LanguagesCubit>().state.selected.language,
                    builder: (translated) => Text(
                      translated,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  onTap: () =>
                      item.route != null ? context.push(item.route!) : null,
                ))
            .toList(),
      );
}
