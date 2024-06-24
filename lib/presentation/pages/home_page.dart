import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gemini_ai_prototype/data/repositories/gemini_talk_repository_impl.dart';
import 'package:gemini_ai_prototype/domain/usecases/text_and_image_use_case.dart';
import 'package:gemini_ai_prototype/domain/usecases/text_only_use_case.dart';
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
  TextOnlyUseCase textOnlyUseCase = TextOnlyUseCase(GeminiTalkRepositoryImpl());
  TextAndImageUseCase textAndImageUseCase =
      TextAndImageUseCase(GeminiTalkRepositoryImpl());

  final FocusNode _focusNode = FocusNode();
  TextEditingController textController = TextEditingController();
  String response = '';
  String base64 = '';
  final ImagePicker _picker = ImagePicker();
  File? _image;




  List<MessageModel> messages = [
    MessageModel(isMine: true,message:'How to learn Flutter? How to learn Flutter?How to learn Flutter?efwefewfewfewfff'),
    MessageModel(isMine: false,message:'In Flutter, the BorderRadius.only constructor is used to apply rounded corners to specific edges of a widget. It provides more granular control compared to other BorderRadius constructors that set a uniform radius for all corners'),
    MessageModel(isMine: true, message: 'What is this picture?', base64: base64Image),
    MessageModel(isMine: false,message:"In Flutter, the BorderRadius.only constructor is used to apply rounded corners to specific edges of a widget. It provides more granular control compared to other BorderRadius constructors that set a uniform radius for all cornersIn Flutter, the BorderRadius.only constructor is used to apply rounded corners to specific edges of a widget. It provides more granular control compared to other BorderRadius constructors that set a uniform radius for all corners")
  ];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  pickImage() async {
    base64 = await Utils.pickAndConvertImage();
    LogService.i('Image selected !!!');
  }

  apiTextOnly() async {
    var text = "What is the best way to learn Flutter development?";
    var either = await textOnlyUseCase.call(text);

    either.fold((l) {
      LogService.d(l);
    }, (r) async {
      LogService.d(r);
    });
  }

  apiTextAndImage() async {
    var text = "What is this image?";
    var base64 = await Utils.pickAndConvertImage();

    var either = await textAndImageUseCase.call(text, base64);
    either.fold((l) {
      LogService.d(l);
    }, (r) async {
      LogService.d(r);
    });
  }

  @override
  void initState() {
    base64 = base64Image;
    // TODO: implement initState
    super.initState();
    apiTextOnly();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: () {
            _focusNode.unfocus();
          },
          child: Container(
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
                    child: messages.isEmpty
                        ? Center(
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child:
                                  Image.asset('assets/images/gemini_icon.png'),
                            ),
                          )
                        : ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              var message = messages[index];
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
                      _image == null
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
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textController,
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
                          const SizedBox(width: 10),
                          // Add some space between TextField and Icons
                          if (textController
                              .text.isEmpty) // Show icons only if text is empty
                            IconButton(
                              onPressed: () async {
                                pickImage();
                              },
                              icon: const Icon(
                                Icons.attach_file,
                                color: Colors.grey,
                              ),
                            ),
                          if (textController
                              .text.isEmpty) // Show icons only if text is empty
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.mic,
                                color: Colors.grey,
                              ),
                            ),
                          IconButton(
                            onPressed: () {
                              if (base64 != '') {
                                // apiTextAndImage(textController.text, base64);
                              } else {
                                // apiTextOnly(textController.text);
                              }
                              _focusNode.unfocus();
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
