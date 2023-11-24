import 'package:chat_app/data/model/message_model.dart';
import 'package:chat_app/data/model/user_model.dart';
import 'package:chat_app/presentation/controllers/cubit/get_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/app_constant.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;
  ChatDetailsScreen({required this.userModel});
  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetDataCubit(),
      child: Builder(builder: (context)
    {
      GetDataCubit.get(context).getMessages(receiverId: userModel.id);
        return BlocConsumer<GetDataCubit, GetDataState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(userModel.image),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Text(
                        userModel.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              body:
              GetDataCubit.get(context).messages.length > 0 ?
              Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var message =
                                      GetDataCubit.get(context).messages[index];
                                  if (userModel.id == message.receiverId) {
                                   return buildMessage(message);
                                  }
                                  return buildMYMessage(message);
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 15,
                                    ),
                                itemCount:
                                    GetDataCubit.get(context).messages.length),
                          ),
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: TextFormField(
                                      controller: messageController,
                                      decoration: const InputDecoration(
                                          hintText:
                                              'type your message here ... ',
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 55,
                                  color: Colors.blue,
                                  child: MaterialButton(
                                    onPressed: () {
                                      GetDataCubit.get(context).sendMessage(
                                          receiverId: userModel.id,
                                          text: messageController.text,
                                          dateTime: DateTime.now().toString());
                                    },
                                    minWidth: 1,
                                    child: const Icon(
                                      Icons.send,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                      color: Colors.blue,
                    )),
            );
          },
        );
      }),
    );
  }

  Widget buildMYMessage(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                )),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(messageModel.text)),
      );
  Widget buildMessage(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: const BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                )),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(messageModel.text)),
      );
}
