import 'package:chat/constant.dart';
import 'package:chat/models/message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.massage,
  });
  final Message massage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding:
          const EdgeInsets.only(left: 10, bottom: 25, top: 25, right: 10),
          child: Text(
            massage.message,
            style: TextStyle(color: Colors.white),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(

            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: kPrimaryColor,
        ),
      ),
    );
  }
}


class ChatBubbleFrendes extends StatelessWidget {
  const ChatBubbleFrendes({
    super.key,
    required this.massage,
  });
  final Message massage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding:
          const EdgeInsets.only(left: 10, bottom: 25, top: 25, right: 10),
          child: Text(
            massage.message,
            style: TextStyle(color: Colors.white),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.indigo,
        ),
      ),
    );
  }
}
