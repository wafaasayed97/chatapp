import 'dart:io';

import 'package:chat_app/data/model/message_model.dart';
import 'package:chat_app/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constant/app_constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
part 'get_data_state.dart';

class GetDataCubit extends Cubit<GetDataState> {
  GetDataCubit() : super(GetDataInitial());
  static GetDataCubit get(context) => BlocProvider.of<GetDataCubit>(context);
  UserModel? model;

  Future<void> getUserData() async {
    emit(GetDataLoadingState());

    await FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .get()
        .then((value) {
      final model = UserModel.fromJson(value.data()!);
      this.model = model;
      print(model.id);
      emit(GetDataLoadedState());
    }).catchError((error) {
      emit(GetDataErrorState(error.toString()));
    });
  }

  var picker = ImagePicker();
  File? profileImage;

  Future<void> getProfileImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      profileImage = File(pickerFile.path);
      emit(GetDataProfilePickerLoadedState());
    } else {
      print(' No Image Selected');
      emit(GetDataProfilePickerErrorState());
    }
  }

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) => {
              value.ref
                  .getDownloadURL()
                  .then((value) => {
                        updateUserData(
                            name: model!.name,
                            phone: model!.phone,
                            image: value),
                        // emit(GetDataUploadProfileLoadedState()),
                      })
                  .catchError(
                      (error) => emit(GetDataUploadProfileErrorState())),
            })
        .catchError(
          (error) => emit(GetDataUploadProfileErrorState()),
        );
  }

  void updateUserData({
    required String name,
    required String phone,
    String? image,
    String? id,
    String? email,
  }) {
    emit(GetDataUploadProfileLoadingState());
    UserModel profileModel = UserModel(
        name: name,
        email: model!.email,
        phone: phone,
        id: model!.id,
        image: image ?? model!.image);
    FirebaseFirestore.instance
        .collection('user')
        .doc(model!.id)
        .update(profileModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(GetDataUploadProfileErrorState());
    });
  }

  List<UserModel> users = [];

  void getUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance
          .collection('user')
          .get()
          .then((value) => {
                value.docs.forEach((element) {
                  if (element.data()['id'] != id) {
                    users.add(UserModel.fromJson(element.data()));
                  }
                }),
                emit(GetDataAllUsersLoadedState()),
              })
          .catchError((error) => emit(GetDataAllUsersErrorState(error)));
    }
  }

  void sendMessage({
    required String receiverId,
    required String text,
    required String dateTime,
  }) {
    MessageModel messageModel = MessageModel(
        receiverId: receiverId, senderId: id, dateTime: dateTime, text: text);

    ///my own chat
    FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) => {emit(GetDataSentMessageLoadedState())})
        .catchError((error) {
      emit(GetDataSentMessageErrorState());
    });

    /// my friend chat
    FirebaseFirestore.instance
        .collection('user')
        .doc(receiverId)
        .collection('chats')
        .doc(id)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) => {emit(GetDataSentMessageLoadedState())})
        .catchError((error) {
      emit(GetDataSentMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetDataGetMessageLoadedState());
    });
  }
}
