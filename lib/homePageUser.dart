import 'package:flutter/material.dart';

class HomePageUser extends StatelessWidget {
  const HomePageUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/logo.png'),
          const SizedBox(height: 5,),
          const Text("User", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
        ],
      ),
    );
  }
}