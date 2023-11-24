import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import '../controllers/cubit/register_cubit.dart';
import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if(state is CreateUserLoadedState){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>HomeScreen()));


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
                          const Text("Register ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold)),
                          const Text(
                              "Register to enjoy yours chat with our application ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              )),
                          const SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: 'name',
                              border: OutlineInputBorder(),
                            ),
                            validator: ValidationBuilder()
                                .maxLength(20)
                                .minLength(4)
                                .build(),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: ValidationBuilder()
                                .email()
                                .maxLength(50)
                                .build(),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: phoneController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              labelText: 'phone',
                              border: OutlineInputBorder(),
                            ),
                            validator: ValidationBuilder()
                                .maxLength(11)
                                .minLength(11)
                                .build(),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline),
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                            validator: ValidationBuilder()
                                .maxLength(15)
                                .minLength(6)
                                .build(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: state is! RegisterLoadingState
                                ? ElevatedButton(
                                    onPressed: () {
                                      if (keyForm.currentState!.validate()) {
                                        RegisterCubit.get(context).userRegister(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            phone: phoneController.text,
                                            name: nameController.text);

                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return  HomeScreen();
                                            }));
                                      }

                                    },
                                    child: const Text('Register'))
                                : const CircularProgressIndicator(),
                          ),
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
