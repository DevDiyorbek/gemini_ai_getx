import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:gemini_ai_prototype/domain/repositories/gemini_talk_repository.dart';

class TextAndImageUseCase {
  final GeminiTalkRepository repository;

  TextAndImageUseCase(this.repository);

  Future<Either<String, String>> call(String text, String base64) async {
    return await repository.onTextAndImage(text, base64);
  }

}