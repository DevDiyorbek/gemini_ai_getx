import 'package:flutter/material.dart';
import '../pages/home_page.dart';

Widget googleSignUp(BuildContext context) {
  return ShaderMask(
    shaderCallback: (bounds) =>
        const LinearGradient(colors: [Colors.blue, Colors.red])
            .createShader(bounds),
    child: OutlinedButton(
      onPressed: () {
        //TODO add google sign in method
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage())
        );
      },
      child: SizedBox(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/google_logo.png", height: 40,),
            const SizedBox(width: 10,),
            const Text("Sign Up with Google", style: TextStyle(fontSize: 18, color:  Colors.white),)
          ],
        ),
      )
    ),
  );
}

