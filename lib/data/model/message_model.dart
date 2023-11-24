import '../../domain/entity/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel(
      {required super.receiverId,
      required super.senderId,
      required super.dateTime,
      required super.text});

  factory MessageModel.fromJson(Map<String, dynamic> json)=>MessageModel(
      receiverId: json['receiverId'],
      senderId:json ['senderId'],
      dateTime:json ['dateTime'],
      text:json ['text']);

  Map<String, dynamic> toMap() =>
      {
        'receiverId' :receiverId,
        'senderId' :senderId ,
        'dateTime':dateTime,
        'text':text
      };
  }
