import 'dart:io';

import 'package:chat_app/presentation/components/text_field_custom.dart';
import 'package:chat_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

import '../controllers/cubit/get_data_cubit.dart';

class ProfileScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetDataCubit()..getUserData(),
      child: Scaffold(
        appBar: AppBar(
          title:  const Text(
            'Profile',
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>  HomeScreen()));
              },
              icon: const Icon(Icons.arrow_back)),
          actions: [
            BlocConsumer<GetDataCubit, GetDataState>(
              listener: (context, state) {},
              builder: (context, state) {
                return TextButton(
                    onPressed: () {
                      GetDataCubit.get(context).uploadProfileImage();
                    },
                    child: Text(
                      'Save profile photo ',
                      style: TextStyle(
                          color: Colors.deepPurple[300],
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ));
              },
            )
          ],
        ),
        body: BlocConsumer<GetDataCubit, GetDataState>(
          listener: (context, state) {
            if (state is GetDataLoadedState) {}
          },
          builder: (context, state) {
            var userModel = GetDataCubit.get(context).model;
            File? profileImage = GetDataCubit.get(context).profileImage;
            nameController.text = userModel?.name ?? '';
            phoneController.text = userModel?.phone ?? '';
            emailController.text = userModel?.email ?? '';

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is GetDataUploadProfileLoadingState)
                      const LinearProgressIndicator(),
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: profileImage == null
                                      ? NetworkImage(userModel?.image ?? '')
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  GetDataCubit.get(context).getProfileImage();
                                },
                                icon: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.blue[300],
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        userModel?.name ?? '',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    TextFieldCustom(
                        'Name',
                        nameController,
                        ValidationBuilder().maxLength(20).minLength(4).build(),
                        const Icon(Icons.person),
                        false),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFieldCustom(
                        'Email',
                        emailController,
                        ValidationBuilder().maxLength(20).minLength(4).build(),
                        const Icon(Icons.email_outlined),
                        false),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFieldCustom(
                        'Phone ',
                        phoneController,
                        ValidationBuilder().email().maxLength(50).build(),
                        const Icon(Icons.phone),
                        false),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 300,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          GetDataCubit.get(context).updateUserData(
                            name: nameController.text,
                            phone: phoneController.text,
                          );
                        },
                        child: const Text(
                          'Edit Profile',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
