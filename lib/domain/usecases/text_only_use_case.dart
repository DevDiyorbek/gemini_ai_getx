import 'package:dartz/dartz.dart';
import 'package:gemini_ai_prototype/domain/repositories/gemini_talk_repository.dart';

class TextOnlyUseCase {
  final GeminiTalkRepository repository;

  TextOnlyUseCase(this.repository);

  Future<Either<String, String>> call(String text) async {
    return await repository.onTextOnly(text);
  }
}
