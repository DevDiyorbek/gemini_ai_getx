import 'package:gemini_ai_prototype/domain/repositories/gemini_telk_repository.dart';

class TextOnlyUseCase {
  final GeminiTalkRepository repository;
  TextOnlyUseCase(this.repository);
  Future<String> call(String text) async {
    return await repository.onTextOnly(text);
  }
}
