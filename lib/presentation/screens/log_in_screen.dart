import 'package:chat_app/presentation/controllers/cubit/Login_cubit.dart';
import 'package:chat_app/presentation/screens/home_screen.dart';
import 'package:chat_app/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

import '../../cache_helper.dart';
import '../components/text_field_custom.dart';

class LogIn extends StatefulWidget {

  LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadedState) {
            CacheHelper.saveData(key: 'id', value: state.id).then((value) => {
              print(state.id),
              print(value),
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (BuildContext context) {
                //     return HomeScreen();
                //   }))
                //
            }
              );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Form(
                      key: keyForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Text("LOGIN ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold)),
                          const Text("enjoy yours chat with our application ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              )),
                          const SizedBox(
                            height: 50,
                          ),
                          TextFieldCustom(
                              'Email',
                              emailController,
                              ValidationBuilder().email().maxLength(50).build(),
                              const Icon(Icons.email),false),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFieldCustom(
                              'Password',
                              passwordController,
                              ValidationBuilder()
                                  .maxLength(15)
                                  .minLength(6)
                                  .build(),
                              const Icon(Icons.lock_outline),true),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 65,
                            child: state is! LoginLoadingState
                                ? ElevatedButton(
                                    onPressed: () {
                                      if (keyForm.currentState!.validate()) {
                                        LoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }

                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (BuildContext context) {
                                        return  HomeScreen();
                                      }));
                                    },
                                    child: const Text('Log in'))
                                : const CircularProgressIndicator(),
                          ),
                          Row(
                            children: [
                              const Text("Don't have Account ?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return RegisterScreen();
                                    }));
                                  },
                                  child: const Text('REGISTER NOW'))
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
