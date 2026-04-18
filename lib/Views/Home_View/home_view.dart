import 'dart:io';
import 'dart:ui';
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFD1FAE5) : const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? const Color(0xFF22C55E) : Colors.transparent,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isSelected ? const Color(0xFF065F46) : Colors.grey,
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
          child: const Icon(Icons.message, color: Colors.black),
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

                if (!Platform.isAndroid)
                  Container(
                    width: 26,
                    height: 26,
                    margin: const EdgeInsets.only(left: 6, right: 10),
                    decoration: const BoxDecoration(
                      color: Color(0xFF0B7A6E),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, size: 18, color: Colors.white),
                  )
                else
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
            preferredSize: const Size.fromHeight(90),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const TextField(
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
                      const SizedBox(width: 8),
                      buildSegment("Unread", ChatFilter.unread),
                      const SizedBox(width: 8),
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

              final imageUrl = chat.userImage.trim();

              return ListTile(
                onTap: () {
                  controller.markAsRead(
                    controller.chatList.indexOf(chat),
                  );

                  Get.to(() => MessageScreen(
                    userName: chat.userName,
                    userImage: imageUrl,
                  ));
                },

                leading: CircleAvatar(
                  backgroundImage: (imageUrl.startsWith('http'))
                      ? NetworkImage(imageUrl)
                      : null,
                  child: (!imageUrl.startsWith('http'))
                      ? const Icon(Icons.person)
                      : null,
                ),

                title: Text(
                  chat.userName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
                            ? const Color(0xFF0B7A6E)
                            : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    if (chat.unreadCount > 0)
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0B7A6E),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            chat.unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        }),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                height: 78,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white.withValues(alpha: 0.12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),

                child: Obx(() {
                  final index = controller.currentIndex.value;

                  final isIOS = !Platform.isAndroid;

                  // IOS
                  final iosItems = [
                    _navItem(Icons.circle_rounded, "Updates", 0),
                    _navItem(Icons.call_rounded, "Calls", 1),
                    _navItem(Icons.groups_rounded, "Communities", 2),
                    _navItem(Icons.chat_bubble_rounded, "Chats", 3),
                    _navItemWidget(
                      child: CircleAvatar(
                        radius: 11,
                        backgroundImage: (controller.userImage.value.isNotEmpty)
                            ? NetworkImage(controller.userImage.value)
                            : null,
                        child: (controller.userImage.value.isEmpty)
                            ? const Icon(Icons.person, size: 16, color: Colors.white)
                            : null,
                      ),
                      label: "Me",
                      index: 4,
                    ),
                  ];

                  // Android
                  final androidItems = [
                    _navItem(Icons.chat_bubble_rounded, "Chats", 0),
                    _navItem(Icons.circle_rounded, "Updates", 1),
                    _navItem(Icons.groups_rounded, "Communities", 2),
                    _navItem(Icons.call_rounded, "Calls", 3),
                  ];

                  final items = isIOS ? iosItems : androidItems;

                  final itemCount = items.length;
                  final width = MediaQuery.of(context).size.width;
                  final itemWidth = (width - 24) / itemCount;

                  return Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 450),
                        curve: Curves.easeOutExpo,
                        left: index * itemWidth,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 10),
                          child: _LiquidBlob(width: itemWidth - 12),
                        ),
                      ),

                      Row(children: items),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Obx(() {
          final isActive = controller.currentIndex.value == index;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: isActive
                    ? const Color(0xFF0B7A6E)
                    : Colors.grey,
              ),
              const SizedBox(height: 4),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: isActive ? 1 : 0.6,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isActive
                        ? const Color(0xFF0B7A6E)
                        : Colors.grey,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _navItemWidget({
    required Widget child,
    required String label,
    required int index,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Obx(() {
          final isActive = controller.currentIndex.value == index;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: isActive
                    ? BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF0B7A6E),
                    width: 2,
                  ),
                )
                    : null,
                padding: const EdgeInsets.all(2),
                child: child,
              ),
              const SizedBox(height: 4),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: isActive ? 1 : 0.6,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isActive
                        ? const Color(0xFF0B7A6E)
                        : Colors.grey,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// Liquid Blob
class _LiquidBlob extends StatefulWidget {
  final double width;

  const _LiquidBlob({required this.width});

  @override
  State<_LiquidBlob> createState() => _LiquidBlobState();
}

class _LiquidBlobState extends State<_LiquidBlob>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              28 + (controller.value * 10),
            ),
            color: const Color(0xFF0B7A6E).withValues(alpha: 0.18),
          ),
        );
      },
    );
  }
}