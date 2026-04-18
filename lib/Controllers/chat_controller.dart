import 'package:get/get.dart';
import '../Models/chat_models.dart';

enum ChatFilter { all, unread, groups }

class ChatController extends GetxController {
  var chatList = <ChatModel>[].obs;
  var selectedFilter = ChatFilter.all.obs;

  var currentIndex = 0.obs;

  RxString userImage = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
    userImage.value =
    "https://scontent.fdac190-1.fna.fbcdn.net/v/t39.30808-6/543061705_801649495722391_8857840311324359157_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=53a332&_nc_ohc=aS0IhzfowNIQ7kNvwEGhNPN&_nc_oc=Adqww3izuZpxyE6v08yPa7UJy2q52HPa5dBLZzKPLBi1CPcBR3RF9XAAU2FPPV53TU0&_nc_zt=23&_nc_ht=scontent.fdac190-1.fna&_nc_gid=MhZReQwLVTylnvOc8N0tww&_nc_ss=7a3a8&oh=00_Af3B_iFfD1eV6sttzyM4jx0PtJtgf8ACEimUOCbgI-M1pQ&oe=69E9B613";
  }

  void loadDummyData() {
    chatList.addAll([
      ChatModel(
        userName: "Sajidul Famnin",
        userImage:
        "https://scontent.fdac190-1.fna.fbcdn.net/v/t39.30808-6/495445486_2124764834615761_8462357812498719257_n.jpg",
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
        userImage:
        "https://scontent.fdac190-1.fna.fbcdn.net/v/t39.30808-6/455002856_1263198271714812_4532740870077446002_n.jpg",
        lastMessage: "Magida keda?",
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
        unreadCount: 0,
      ),

      ChatModel(
        userName: "Tohid",
        userImage:
        "https://scontent.fdac190-1.fna.fbcdn.net/v/t39.30808-6/484190364_2159322591168442_5024412920701761938_n.jpg",
        lastMessage: "Koi tui?",
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
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

  void changeTab(int index) {
    currentIndex.value = index;
  }
}