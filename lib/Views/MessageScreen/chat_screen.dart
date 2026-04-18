import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {

  final String userName;
  final String userImage;

  const MessageScreen(
      {
        super.key,
        required this.userName,
        required this.userImage
      }
      );

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();

  List<Map<String, dynamic>> messages = [
    {
      "text": "Hello, how are you?",
      "isMe": false,
      "time": DateTime.now().subtract(Duration(minutes: 1)),
    },
    {
      "text": "Fine, And You?",
      "isMe": true,
      "time": DateTime.now().subtract(Duration(minutes: 1)),
    },
    {
      "text": "What are you doing now?",
      "isMe": false,
      "time": DateTime.now().subtract(Duration(minutes: 1)),
    },
    {
      "text": "Nothing much, just chilling",
      "isMe": true,
      "time": DateTime.now().subtract(Duration(minutes: 1)),
    },
  ];

  void sendMessage(dynamic messageController) {
    if (messageController.text.isEmpty) return;

    setState(() {
      messages.add({
        "text": messageController.text,
        "isMe": true,
        "time": DateTime.now(),
      });
    });

    messageController.clear();
  }

  String formatTime(DateTime time) {
    return "${time.hour}:${time.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  widget.userImage,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF111827),
                  ),
                ),
                Text(
                  "Online",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF111827),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.videocam),
            color: Color(0xFF111827),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.call),
            color: Color(0xFF111827),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.more_vert),
            color: Color(0xFF111827),
          ),
        ],
        backgroundColor: Color(0xFF0F9D8F),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(15),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final data = messages[index];
                  final isMe = data["isMe"] == true;
                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7
                      ),
                      decoration: BoxDecoration(
                          color: isMe ? Color(0xFF0F9D8F) : Color(0xFFE5E7EB),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: isMe ? Radius.circular(20) : Radius.circular(0),
                            bottomRight: isMe ? Radius.circular(0) : Radius.circular(20),
                          )
                      ),
                      child: Column(
                        crossAxisAlignment:
                        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['text'],
                            style: TextStyle(
                              color: isMe ? Colors.white : Color(0xFF111827),
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 11),
                    height: 60,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration:BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child: Center(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: "Enter Message",
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.attach_file),
                          ),
                          prefixIcon: IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.camera_alt_outlined)
                          ),
                        ),
                      ),
                    )
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xFF0F9D8F),
                  child: IconButton(
                    onPressed: (){
                      sendMessage(_messageController);
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
