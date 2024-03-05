

class Message{
  Message( this.message,this.email );
 final String message;
 final String email;


  factory Message.fromJson(jsonData){
    return Message(jsonData['message'],jsonData['email']);
  }
}