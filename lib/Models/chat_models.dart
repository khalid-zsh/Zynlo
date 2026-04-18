class ChatModel {
  String userName;
  String userImage;
  String lastMessage;
  DateTime lastMessageTime;
  int unreadCount;
  bool isGroup;

  ChatModel({
    required this.userName,
    required this.userImage,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    this.isGroup = false,
  });
}