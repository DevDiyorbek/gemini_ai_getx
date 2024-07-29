import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gemini_ai_prototype/data/repositories/gemini_talk_repository_impl.dart';
import 'package:gemini_ai_prototype/domain/usecases/text_and_image_use_case.dart';
import 'package:gemini_ai_prototype/domain/usecases/text_only_use_case.dart';
import 'package:gemini_ai_prototype/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constants/constants.dart';
import '../../core/services/log_service.dart';
import '../../core/services/utils_service.dart';
import '../../data/models/message_model.dart';
import '../widgets/item_gemini_message.dart';
import '../widgets/item_user_message.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.find<HomeController>();

  @override
  void dispose() {
    homeController.textController.dispose();
    homeController.focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: () {
            homeController.focusNode.unfocus();
          },
          child: GetBuilder<HomeController>(
            builder: (_) {
              return Container(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 45,
                      child: Image(
                        image: AssetImage('assets/images/gemini_logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        child: homeController.messages.isEmpty
                            ? Center(
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                      'assets/images/gemini_profile.png'),
                                ),
                              )
                            : ListView.builder(
                                itemCount: homeController.messages.length,
                                itemBuilder: (context, index) {
                                  var message = homeController.messages[index];
                                  if (message.isMine!) {
                                    return itemOfUserMessage(message);
                                  } else {
                                    return itemOfGeminiMessage(message);
                                  }
                                },
                              ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20, left: 20),
                      padding: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey, width: 1.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          homeController.image == null
                              ? SizedBox.shrink()
                              : Container(
                                  margin: EdgeInsets.only(top: 15),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    // color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      homeController.image!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: homeController.textController,
                                  maxLines: null,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Message',
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                  onChanged: (String text) {
                                    setState(
                                        () {}); // Trigger a rebuild to update the UI
                                  },
                                ),
                              ),
                              InkWell(
                                child: const Icon(
                                  Icons.attach_file,
                                  color: Colors.grey,
                                ),
                                onTap: () async {
                                  homeController.onSelectImage();
                                },
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                child: const Icon(
                                  Icons.mic,
                                  color: Colors.grey,
                                ),
                                onTap: () {},
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.grey,
                                ),
                                onTap: () {
                                  var text = homeController.textController.text
                                      .toString()
                                      .trim();
                                  homeController.onSendButtonPressed(text);
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
