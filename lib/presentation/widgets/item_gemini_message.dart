import 'package:flutter/material.dart';
import '../../data/models/message_model.dart';

Widget itemOfGeminiMessage(MessageModel message){
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(top: 15, bottom: 15),
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 30,
                child: Image.asset('assets/images/gemini_profile.png'),
              ),
              const Icon(Icons.volume_up, color: Colors.white70,)
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: Text(
              message.message!,
              style:
              const TextStyle(color: Color.fromRGBO(173, 173, 176, 1), fontSize: 16),
            ),
          ),
        ],
      ),
    ),
  );
}