import 'package:gemini_ai_prototype/domain/repositories/gemini_telk_repository.dart';

import '../../core/services/log_service.dart';
import '../datasources/remote/http_service.dart';

class GeminiTalkRepositoryImpl extends GeminiTalkRepository{
  @override
  Future<String> onTextOnly(String text) async {
    var response = await Network.POST(Network.API_GEMINI_TALK, Network.paramsTextOnly(text));
    var talkResult = Network.parseGeminiTalk(response!);
    var result = talkResult.candidates[0].content.parts[0].text;
    LogService.i(result);
    return result;
  }

  @override
  Future<String> onTextAndImage(String text, String base64Image) async {
    var response = await Network.POST(Network.API_GEMINI_TALK, Network.paramsTextAndImage(text, base64Image));
    var talkResult = Network.parseGeminiTalk(response!);
    var result = talkResult.candidates[0].content.parts[0].text;
    LogService.i(result);
    return result;
  }
}