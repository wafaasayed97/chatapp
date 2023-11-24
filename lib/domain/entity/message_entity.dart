class MessageEntity {
  final String receiverId;
  final String senderId;
  final String dateTime;
  final String text;

  MessageEntity(
      {required this.receiverId,
      required this.senderId,
      required this.dateTime,
      required this.text});
}
