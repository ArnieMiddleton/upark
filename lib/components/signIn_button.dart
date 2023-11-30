import 'package:flutter/material.dart';

class signIn_button extends StatelessWidget{

  final Function()? onClick;

  const signIn_button({super.key, required this.onClick,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Center(
        child: Text(
          "Sign In",
           style: TextStyle(color: Colors.red[700], fontSize: 20, fontWeight: FontWeight.bold),
           ),
           ),
    );
    }
}