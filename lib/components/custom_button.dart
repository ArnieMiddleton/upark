import 'package:flutter/material.dart';

class custom_button extends StatelessWidget{

  final Function()? onClick;

  const custom_button({super.key, required this.onClick,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(color: Colors.red[700]),
      child: const Center(
        child: Text(
           'Sign In',
           style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
           ),
           ),
    )
    );
    }
}