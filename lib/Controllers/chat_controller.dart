import 'package:get/get.dart';
import '../Models/chat_models.dart';

enum ChatFilter { all, unread, groups }

class ChatController extends GetxController {
  var chatList = <ChatModel>[].obs;
  var selectedFilter = ChatFilter.all.obs;
  var selectedIndex = 0.obs;
  var bottomTitle = "Chats".obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  void loadDummyData() {
    chatList.addAll([
      ChatModel(
        userName: "Sajidul Famnin",
        userImage: "https://scontent.fdac190-1.fna.fbcdn.net/v/t39.30808-6/495445486_2124764834615761_8462357812498719257_n.jpg?stp=cp6_dst-jpg_tt6&_nc_cat=106&ccb=1-7&_nc_sid=53a332&_nc_ohc=_EEO3Su6-2sQ7kNvwFiv7li&_nc_oc=AdpkVgaP83K8FDvyOiLadGbukb78cnRFsGqFcE98oN2C3ztaQyrSH2hgRJDdr1yf4VA&_nc_zt=23&_nc_ht=scontent.fdac190-1.fna&_nc_gid=QQ5EX46wtyo5kgKYCDapsA&_nc_ss=7a3a8&oh=00_Af0KIzDhCownFsKqVfXC1g6v5ooH8yf96OZ6-Hd0pae7Yw&oe=69E972A3",
        lastMessage: "Phn dhor",
        lastMessageTime: DateTime.now(),
        unreadCount: 3,
        isGroup: false,
      ),
      ChatModel(
        userName: "Study Group",
        userImage: "https://i.pravatar.cc/150?img=5",
        lastMessage: "Assignment submit koro",
        lastMessageTime: DateTime.now(),
        unreadCount: 5,
        isGroup: true,
      ),
      ChatModel(
        userName: "Sakib",
        userImage: "https://scontent.fdac190-1.fna.fbcdn.net/v/t39.30808-6/455002856_1263198271714812_4532740870077446002_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=53a332&_nc_ohc=oPSsdtXMWAYQ7kNvwFBGDBc&_nc_oc=AdrkAqgagiSqtoQmTvvtkwxvpO7mDd3PvyCbJcdW7-RZMbsgXDpN2ijXIdhKJ593c64&_nc_zt=23&_nc_ht=scontent.fdac190-1.fna&_nc_gid=TEW6pD4AKNQJQMKzZhFHTg&_nc_ss=7a3a8&oh=00_Af1WrJCKtrH44INoZQ4cLiTVUeNjrmTEcs3jIDSmHueeBg&oe=69E9693F",
        lastMessage: "Magida keda?",
        lastMessageTime: DateTime.now().subtract(Duration(hours: 2)),
        unreadCount: 0,
      ),
      ChatModel(
        userName: "Tohid",
        userImage: " https://scontent.fdac190-1.fna.fbcdn.net/v/t39.30808-6/484190364_2159322591168442_5024412920701761938_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=53a332&_nc_ohc=w6OZ-C6KvR4Q7kNvwFVTNqJ&_nc_oc=AdplMf1-uPeIP_xAse9dIXGRrQxIm6eA2GXgCxegACULo_3Ik6sSMajHddm5LSYaQ_Q&_nc_zt=23&_nc_ht=scontent.fdac190-1.fna&_nc_gid=ha_V4ircunNz3S6Z2MZudw&_nc_ss=7a3a8&oh=00_Af3LVYQ5VLYNFEUezJL2eJreZKAYyhDZKrcQj4YV4ZwajA&oe=69E949FE",
        lastMessage: "Koi tui?",
        lastMessageTime: DateTime.now().subtract(Duration(hours: 2)),
        unreadCount: 1,
      ),
    ]);
  }

  List<ChatModel> get filteredChats {
    switch (selectedFilter.value) {
      case ChatFilter.unread:
        return chatList.where((c) => c.unreadCount > 0).toList();

      case ChatFilter.groups:
        return chatList.where((c) => c.isGroup).toList();

      case ChatFilter.all:
        return chatList;
    }
  }

  void setFilter(ChatFilter filter) {
    selectedFilter.value = filter;
  }

  void markAsRead(int index) {
    chatList[index].unreadCount = 0;
    chatList.refresh();
  }

  int get totalUnread =>
      chatList.fold(0, (sum, chat) => sum + chat.unreadCount);
  void changeTab(int index) {
    selectedIndex.value = index;

    switch (index) {
      case 0:
        bottomTitle.value = "Chats";
        break;
      case 1:
        bottomTitle.value = "Updates";
        break;
      case 2:
        bottomTitle.value = "Communities";
        break;
      case 3:
        bottomTitle.value = "Calls";
        break;
    }
  }
}