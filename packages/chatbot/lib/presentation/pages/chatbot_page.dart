import 'dart:io';

import 'package:chatbot/domain/entities/chat.dart';
import 'package:chatbot/presentation/provider/chatbot_notifier.dart';
import 'package:chatbot/presentation/widgets/receive_card.dart';
import 'package:chatbot/presentation/widgets/send_card.dart';
import 'package:core/presentation/widgets/app_bar_leading.dart';
import 'package:core/presentation/widgets/app_bar_title.dart';
import 'package:core/presentation/widgets/loading_indicator.dart';
import 'package:core/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../provider/pick_image_notifier.dart';
import '../provider/upload_notifier.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  static const routeName = '/chat-bot';

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final _sendController = TextEditingController();
  final List<Chat> _chats = [
    Chat(
        text:
            "Hello, I'm **Mainchick Chatbot**. You can use automatic features related to your chicken farming problems. Anything I can help?"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeading(),
        title: const AppBarTitle(title: 'Mainchick Chatbot'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 21),
            child: SvgPicture.asset('assets/icons/chicken_circle.svg'),
          ),
        ],
      ),
      backgroundColor: white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 25,
                left: 25,
                right: 25,
                bottom: 110,
              ),
              child: ListView.builder(
                reverse: true,
                itemCount: _chats.length,
                itemBuilder: (context, index) {
                  final chat = _chats[index];
                  if (chat.isLoading) {
                    return const Loading();
                  } else if (index == _chats.length - 1) {
                    return Column(
                      children: [
                        ReceiveCard(chat),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 342,
                            decoration: ShapeDecoration(
                              color: white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x0A000000),
                                  blurRadius: 25,
                                  offset: Offset(0, 8),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {},
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(10)),
                                    child: const SizedBox(
                                      width: double.infinity,
                                      height: 46,
                                      child: Center(
                                        child: Text(
                                          "Disease Detection",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF3CA2F2),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  color: Color(0xFFE9E9E9),
                                  thickness: 1,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      _onSend(
                                          'Tips Regarding Chicken Livestock');
                                    },
                                    child: const SizedBox(
                                      width: double.infinity,
                                      height: 46,
                                      child: Center(
                                        child: Text(
                                          "Tips Regarding Chicken Livestock",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF3CA2F2),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  color: Color(0xFFE9E9E9),
                                  thickness: 1,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      _onSend('Customer care');
                                    },
                                    borderRadius: const BorderRadius.vertical(
                                        bottom: Radius.circular(10)),
                                    child: const SizedBox(
                                      width: double.infinity,
                                      height: 46,
                                      child: Center(
                                        child: Text(
                                          "Customer care",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF3CA2F2),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    );
                  } else if (chat.isReceive) {
                    return ReceiveCard(chat);
                  } else {
                    return SendCard(chat);
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 77,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 21),
                decoration: BoxDecoration(
                  color: white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0C000000),
                      blurRadius: 3,
                      offset: Offset(0, -4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {},
                        child: SvgPicture.asset('assets/icons/camera.svg'),
                      ),
                    ),
                    Container(
                      width: 1,
                      margin: const EdgeInsets.only(left: 25, right: 15),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFC9C9C9),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _sendController,
                        decoration: const InputDecoration(
                          hintText: "Write message...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          _onSend(_sendController.text);
                          setState(() {
                            _sendController.clear();
                          });
                        },
                        child: SvgPicture.asset('assets/icons/send.svg'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onSend(String message) async {
    if (message.isEmpty) return;

    setState(() {
      _chats.insert(0, Chat(text: message, isReceive: false));
      _chats.insert(
        0,
        Chat(text: '', isLoading: true),
      );
    });

    final chatbotProvider = context.read<ChatBotNotifier>();

    await chatbotProvider.fetchChatbot(message);

    if (chatbotProvider.chat != null) {
      setState(() {
        _chats.removeAt(0);
        _chats.insert(0, chatbotProvider.chat!);
      });
    }
  }

  _onUpload() async {
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    final uploadProvider = context.read<UploadNotifier>();

    final homeProvider = context.read<PickImageNotifier>();
    final imagePath = homeProvider.imagePath;
    final imageFile = homeProvider.imageFile;
    if (imagePath == null || imageFile == null) return;

    final fileName = imageFile.name;
    final bytes = await imageFile.readAsBytes();

    final newBytes = await uploadProvider.compressImage(bytes);

    await uploadProvider.upload(
      newBytes,
      fileName,
    );

    if (uploadProvider.uploadResponse != null) {
      homeProvider.setImageFile(null);
      homeProvider.setImagePath(null);
    }

    scaffoldMessengerState.showSnackBar(
      SnackBar(content: Text(uploadProvider.message)),
    );
  }

  _onGalleryView() async {
    final provider = context.read<PickImageNotifier>();

    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  _onCameraView() async {
    final provider = context.read<PickImageNotifier>();

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  Widget _showImage() {
    final imagePath = context.read<PickImageNotifier>().imagePath;
    return kIsWeb
        ? Image.network(
            imagePath.toString(),
            fit: BoxFit.contain,
          )
        : Image.file(
            File(imagePath.toString()),
            fit: BoxFit.contain,
          );
  }
}
