import 'package:flutter/material.dart';

Widget googleSignUp(BuildContext context) {
  return ShaderMask(
    shaderCallback: (bounds) =>
        const LinearGradient(colors: [Colors.blue, Colors.red])
            .createShader(bounds),
    child: OutlinedButton(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 15)),
      ),
      onPressed: () {
        //TODO add google sign in method
      },
      child: Row(
        children: [
          Image.asset("assets/images/google_logo.png", height: 40,),
          const Text("Sign Up with Google", style: TextStyle(fontSize: 18, color: Colors.white),)
        ],
      )
    ),
  );
}

