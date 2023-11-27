import 'package:diseases/constants/constants.dart';
import 'package:diseases/presentations/widgets/profile_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/bloc/auth_status/auth_status_bloc.dart';
import '../../business_logic/cubit/profile_page_view/profile_view_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = context.watch<ProfileViewCubit>().state.profileIndex;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Basic info',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () => (currentIndex == 0)
              ? Navigator.pop(context)
              : context
                  .read<ProfileViewCubit>()
                  .switchToNextSession(profileIndex: 0),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        actions: currentIndex == 0
            ? [
                IconButton(
                  onPressed: () => context
                      .read<ProfileViewCubit>()
                      .switchToNextSession(profileIndex: 1),
                  icon: const Icon(Icons.edit),
                ),
              ]
            : null,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<AuthStatusBloc, AuthStatusState>(
        builder: (context, state) {
          if (state is UserAuthenticated) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: buildProfileFields(currentUser),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildProfileFields(dynamic user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ProfilePicture(imageUrl: userData['profileImage'].toString()),
        ProfileField(
            title: 'Your Name', value: '${user.firstName} ${user.lastName}'),
        ProfileField(title: 'Email Address', value: user.email.toString()),
        // ProfileField(title: 'Phone Number', value: user.phone.toString()),
      ],
    );
  }
}
