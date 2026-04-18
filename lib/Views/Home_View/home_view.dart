import 'dart:io';
import 'package:Zynlo/Views/MessageScreen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Controllers/chat_controller.dart';

class HomeView extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());

  HomeView({super.key});

  String formatTime(DateTime time) {
    final now = DateTime.now();

    if (now.difference(time).inDays == 0) {
      return DateFormat('h:mm a').format(time);
    } else {
      return DateFormat('dd/MM/yyyy').format(time);
    }
  }

  Widget buildSegment(String text, ChatFilter filter) {
    return GestureDetector(
      onTap: () => controller.setFilter(filter),
      child: Obx(() {
        final isSelected = controller.selectedFilter.value == filter;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFFD1FAE5) : Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? Color(0xFF22C55E) : Colors.transparent,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isSelected ? Color(0xFF065F46) : Colors.grey,
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {},
          child: Icon(
              Icons.message,
              color: Colors.black
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!Platform.isAndroid)
                SizedBox(
                  height: 20,
                  child: Icon(Icons.more_horiz, size: 22, color: Color(0xFF111827)),
                ),
              const Text(
                "Zynlo",
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    size: 22,
                    color: Color(0xFF111827),
                  ),
                ),

                // IOS
                if (!Platform.isAndroid)
                  Container(
                    width: 26,
                    height: 26,
                    margin: const EdgeInsets.only(left: 6, right: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF0B7A6E),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),

                // Android
                if (Platform.isAndroid)
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      size: 22,
                      color: Color(0xFF111827),
                    ),
                  ),
              ],
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    children: [
                      buildSegment("All", ChatFilter.all),
                      SizedBox(width: 8),
                      buildSegment("Unread", ChatFilter.unread),
                      SizedBox(width: 8),
                      buildSegment("Groups", ChatFilter.groups),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        body: Obx(() {
          final chats = controller.filteredChats;

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];

              return ListTile(
                onTap: () {
                  controller.markAsRead(
                    controller.chatList.indexOf(chat),
                  );

                  Get.to(() => MessageScreen(
                    userName: chat.userName,
                    userImage: chat.userImage,
                  ));
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(chat.userImage),
                ),
                title: Text(
                  chat.userName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  chat.lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: chat.unreadCount > 0
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: chat.unreadCount > 0
                        ? Colors.black
                        : Colors.grey,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatTime(chat.lastMessageTime),
                      style: TextStyle(
                        color: chat.unreadCount > 0
                            ? Color(0xFF0B7A6E)
                            : Colors.grey,
                      ),
                    ),
                    SizedBox(height: 5),
                    if (chat.unreadCount > 0)
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Color(0xFF0B7A6E),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            chat.unreadCount.toString(),
                            style: TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        }),

        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {},
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_bubble_outline,
                color: Colors.black,
              ),
              label: "Chats",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.circle_outlined, color: Colors.black,),
              label: "Updates",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people, color: Colors.black,),
              label: "Communities",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call, color: Colors.black,),
              label: "Calls",
            ),
          ],
        ),
      ),
    );
  }
}