import 'package:chat_app/data/model/user_model.dart';
import 'package:chat_app/presentation/controllers/cubit/get_data_cubit.dart';
import 'package:chat_app/presentation/screens/chat_details_screen.dart';
import 'package:chat_app/presentation/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'log_in_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetDataCubit()..getUsers(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[200],
          title: const Text(
            'Chats',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ],
        ),
        body: BlocConsumer<GetDataCubit, GetDataState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (GetDataCubit.get(context).users.isNotEmpty) {
              return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildChatItem(GetDataCubit.get(context).users[index],context),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: GetDataCubit.get(context).users.length);
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
              ));
            }
          },
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 30, 8, 20),
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.exit_to_app_outlined),
                  onTap: () async {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => LogIn()),
                        (route) => false);
                  },
                  iconColor: Colors.black,
                  title: const Text("Sign out",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    onTap: () async {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProfileScreen()),
                          (route) => false);
                    },
                    title: const Text(
                      "profile",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildChatItem(UserModel model,context) => InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
            return ChatDetailsScreen(userModel: model);
          }));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(model.image),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 8, 8),
                child: Text(
                  model.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
}
