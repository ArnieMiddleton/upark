import 'package:flutter/material.dart';

class signUp_button extends StatelessWidget{

  final Function()? onClick;

  const signUp_button({super.key, required this.onClick,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Center(
        child: Text(
          "Sign Up",
           style: TextStyle(color: Colors.red[700], fontSize: 20, fontWeight: FontWeight.bold),
           ),
           ),
    );
    }
}