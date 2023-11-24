import 'package:chat_app/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(id: value.user!.uid, email: email, phone: phone, name: name);
      //emit(RegisterLoadedState());
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String phone,
    required String email,
    required String id,
  }) {
    UserModel model = UserModel(
        email: email,
        name: name,
        phone: phone,
        id: id,
        image:
            'https://e7.pngegg.com/pngimages/439/304/png-clipart-millennials-social-media-social-network-generation-z-social-media-purple-computer-network.png'
    );

    FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserLoadedState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_rounded;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_rounded : Icons.visibility_off_rounded;

    emit(RegisterChangePasswordState());
  }
}
