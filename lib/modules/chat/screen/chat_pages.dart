import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:tailored/all_constants/all_constants.dart';
 import 'package:tailored/all_widgets/loading_view.dart';
import 'package:tailored/modules/auth/screen/login.dart';
import 'package:tailored/model/chat_user.dart';
import 'package:tailored/providers/provider_notifier.dart';
import 'package:tailored/providers/auth_provider.dart';
import 'package:tailored/providers/home_provider.dart';
import 'package:tailored/modules/chat/screen/chat_page.dart';

import 'package:tailored/utilities/debouncer.dart';
import 'package:tailored/utilities/keyboard_utils.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ScrollController scrollController = ScrollController();

  int _limit = 20;
  final int _limitIncrement = 20;
  String _textSearch = "";
  bool isLoading = false;

  late AuthProvider authProvider;
  late String currentUserId;
  late HomeProvider homeProvider;

  Debouncer searchDebouncer = Debouncer(milliseconds: 300);
  StreamController<bool> buttonClearController = StreamController<bool>();
  TextEditingController searchTextEditingController = TextEditingController();

  Future<void> googleSignOut() async {
    authProvider.googleSignOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  Future<bool> onBackPress() {
    openDialog();
    return Future.value(false);
  }

  Future<void> openDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return SimpleDialog(
            backgroundColor: AppColors.burgundy,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Exit Application',
                  style: TextStyle(color: AppColors.white),
                ),
                Icon(
                  Icons.exit_to_app,
                  size: 30,
                  color: Colors.white,
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.dimen_10),
            ),
            children: [
              vertical10,
              const Text(
                'Are you sure?',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: AppColors.white, fontSize: Sizes.dimen_16),
              ),
              vertical15,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 0);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 1);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(Sizes.dimen_8),
                      ),
                      padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: AppColors.spaceCadet),
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        })) {
      case 0:
        break;
      case 1:
        exit(0);
    }
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    buttonClearController.close();
  }

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    homeProvider = context.read<HomeProvider>();
    if (authProvider.getFirebaseUserId()?.isNotEmpty == true) {
      currentUserId = authProvider.getFirebaseUserId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false);
    }

    scrollController.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Chat'),
              bottom: const TabBar(
                tabs: [
                  Tab(text: "Arabic - English"),
                  Tab(text: "general"),
                ],
                isScrollable: true,
                labelStyle: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold),
                labelColor:Color(0xff56A03F),
                indicatorColor:Color(0xff56A03F),
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.symmetric(
                    horizontal: 6, vertical: 0),
              ),
            ),
            body: TabBarView(
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: homeProvider.getFirestoreData(
                          FirestoreConstants.pathUserCollection,
                          _limit,
                          _textSearch),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if ((snapshot.data?.docs.length ?? 0) > 0) {
                            return ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) => buildItem(
                                  context, snapshot.data?.docs[index],'dStcfNY6R9VdgudeGHzZ69'),
                              controller: scrollController,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                              const Divider(),
                            );
                          } else {
                            return const Center(
                              child: Text('No user found...'),
                            );
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Stack(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // buildSearchBar(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text("Direct messages",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 20),),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: homeProvider.getFirestoreData(
                                    FirestoreConstants.pathUserCollection,
                                    _limit,
                                    _textSearch),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    if ((snapshot.data?.docs.length ?? 0) > 0) {
                                      return ListView.separated(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) => buildItem(
                                            context, snapshot.data?.docs[index],null),
                                        controller: scrollController,
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                        const Divider(),
                                      );
                                    } else {
                                      return const Center(
                                        child: Text('No user found...'),
                                      );
                                    }
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(height: 1,color: Colors.black12,width: MediaQuery.of(context).size.width,),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text("Channel",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 20),),
                              ),

                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        child:
                        isLoading ? const LoadingView() : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),

              ],
            )),
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(Sizes.dimen_10),
      height: Sizes.dimen_50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.dimen_30),
        color: AppColors.spaceLight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: Sizes.dimen_10,
          ),
          const Icon(
            Icons.person_search,
            color: AppColors.white,
            size: Sizes.dimen_24,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              controller: searchTextEditingController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  buttonClearController.add(true);
                  setState(() {
                    _textSearch = value;
                  });
                } else {
                  buttonClearController.add(false);
                  setState(() {
                    _textSearch = "";
                  });
                }
              },
              decoration:  InputDecoration(
                hintText: 'Search here...',
                hintStyle: TextStyle(color: AppColors.white),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                fillColor: AppColors.spaceLight,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_30)),
                    borderSide: BorderSide(color: AppColors.spaceLight)),
                filled: true,
                contentPadding:
                EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
              ),
            ),
          ),
          StreamBuilder(
              stream: buttonClearController.stream,
              builder: (context, snapshot) {
                return snapshot.data == true
                    ? GestureDetector(
                        onTap: () {
                          searchTextEditingController.clear();
                          buttonClearController.add(false);
                          setState(() {
                            _textSearch = '';
                          });
                        },
                        child: const Icon(
                          Icons.clear_rounded,
                          color: AppColors.greyColor,
                          size: 20,
                        ),
                      )
                    : const SizedBox.shrink();
              })
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot? documentSnapshot,filter) {
    final themeColor = Provider.of<Provider_control>(context);
    final firebaseAuth = FirebaseAuth.instance;
    if (documentSnapshot != null) {
      ChatUser userChat = ChatUser.fromDocument(documentSnapshot);
      print(userChat.courceid);
      print(userChat.courceName);
      print(userChat.displayName);

      if (userChat.id == currentUserId) {
        return const SizedBox.shrink();
      } else if (filter!=null) {
        if(userChat.courceid == filter) {
          return TextButton(
            onPressed: () {
              if (KeyboardUtils.isKeyboardShowing()) {
                KeyboardUtils.closeKeyboard(context);
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatPage(
                            peerId: userChat.id,
                            peerAvatar: userChat.photoUrl,
                            peerNickname: userChat.displayName,
                            userAvatar: themeColor.user.avatar.toString(),
                          )));
            },
            child: Row(
              children: [
                userChat.photoUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(Sizes.dimen_10),
                        child: CachedNetworkImage(
                          imageUrl: userChat.photoUrl,
                          fit: BoxFit.cover,
                          width: 30,
                          height: 30,
                        ),
                      )
                    : const Icon(
                        Icons.account_circle,
                        size: 50,
                      ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  userChat.displayName,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
                )
              ],
            ),
          );
        }
        else  return const SizedBox.shrink();
      } else {
        return TextButton(
          onPressed: () {
            if (KeyboardUtils.isKeyboardShowing()) {
              KeyboardUtils.closeKeyboard(context);
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          peerId: userChat.id,
                          peerAvatar: userChat.photoUrl,
                          peerNickname: userChat.displayName,
                          userAvatar: themeColor.user.avatar.toString(),
                        )));
          },
          child: Row(
            children: [
              userChat.photoUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(Sizes.dimen_10),
                      child: CachedNetworkImage(
                        imageUrl: userChat.photoUrl,
                        fit: BoxFit.cover,
                        width: 30,
                        height: 30,
                      ),
                    )
                  : const Icon(
                      Icons.account_circle,
                      size: 50,
                    ),
              SizedBox(
                width: 10,
              ),
              Text(
                userChat.displayName,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
              )
            ],
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}
