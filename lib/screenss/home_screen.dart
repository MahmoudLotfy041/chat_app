import 'package:chat/models/message.dart';
import 'package:chat/screenss/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constant.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.email});
  final String email;
  TextEditingController controller = TextEditingController();
  CollectionReference  message =
      FirebaseFirestore.instance.collection('message');

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: message.orderBy('createAt').snapshots(),
        builder: (context,snapshot){

      if(snapshot.hasData){
       List<Message> messageList =[];
       for(int i=0;i<snapshot.data!.docs.length;i++){
         messageList.add(Message.fromJson(snapshot.data!.docs[i]));
       }
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/scholar.png",
                  height: 50,
                  width: 50,
                ),
                Text(
                  "Chat",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            backgroundColor: kPrimaryColor,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _controller,
                  // shrinkWrap: true,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].email==email? ChatBubble(massage: messageList[index],)
                                            :ChatBubbleFrendes(massage:messageList[index] );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller,
                  onFieldSubmitted: (data) {
                    message.add({
                      'message': data,
                      'createAt':DateTime.now(),
                      'email':email,
                    });
                    controller.clear();
                    _controller.animateTo(
                      _controller.position.maxScrollExtent,
                      duration: Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
                  decoration: InputDecoration(
                      hintText: "Send Message",
                      suffixIcon: Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              )
            ],
          ),
        ) ;
      }
     return const Text("");
    });
  }
}

