import 'package:gemini_ai_prototype/domain/repositories/gemini_telk_repository.dart';

class TextAndImageUseCase {
  final GeminiTalkRepository repository;

  TextAndImageUseCase(this.repository);

  Future<String> call(String text, String base64Image) async {
    return await repository.onTextAndImage(text, base64Image);
  }
}