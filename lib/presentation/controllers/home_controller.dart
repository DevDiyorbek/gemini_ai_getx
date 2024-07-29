import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/services/log_service.dart';
import '../../core/services/utils_service.dart';
import '../../data/models/message_model.dart';
import '../../data/repositories/gemini_talk_repository_impl.dart';
import '../../domain/usecases/text_and_image_use_case.dart';
import '../../domain/usecases/text_only_use_case.dart';

class HomeController extends GetxController {
  TextOnlyUseCase textOnlyUseCase = TextOnlyUseCase(GeminiTalkRepositoryImpl());
  TextAndImageUseCase textAndImageUseCase =
      TextAndImageUseCase(GeminiTalkRepositoryImpl());

  final FocusNode focusNode = FocusNode();
  TextEditingController textController = TextEditingController();
  String response = '';
  String base64 = '';
  final ImagePicker picker = ImagePicker();
  File? image;
  String? pickedImage;


  List<MessageModel> messages = [];
  apiTextOnly(String text) async {
    var either = await textOnlyUseCase.call(text);

    either.fold((l) {
      LogService.d(l);
    }, (r) async {
      LogService.d(r);
      updateMessages(MessageModel(isMine: false, message: r));
    });
  }

  apiTextAndImage(String text, String base64) async {
    var either = await textAndImageUseCase.call(text, base64);
    either.fold((l) {
      LogService.d(l);
    }, (r) async {
      LogService.d(r);
      updateMessages(MessageModel(isMine: false, message: r));
    });
  }

  updateMessages(MessageModel messageModel){
    messages.add(messageModel);
    update();
  }
  onSendButtonPressed(String text) async {
    if (pickedImage == null) {
      await apiTextOnly(text);
    } else {
      await apiTextAndImage(text, pickedImage!);
    }
    
    updateMessages(MessageModel(isMine: true, message: text));
    textController.clear();
  }

  onSelectImage() async {
    var base64 = await Utils.pickAndConvertImage();
    pickedImage = base64;
    update();
  }


}
