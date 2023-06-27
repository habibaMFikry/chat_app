import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/widgets/chat_buble.dart';


class ChatPage extends StatelessWidget {
   static String id = 'ChatPage';
  //String? dataON;

  final _controller = ScrollController();

 final  List<Message> messagesList = [];

  /*CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);*/
  final TextEditingController controller = TextEditingController();

  ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    /*return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }*/

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            const Text('chat'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList =
                    BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? ChatBuble(
                            message: messagesList[index],
                          )
                        : ChatBubleForFriend(message: messagesList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: email);
                //dataON = data;
                /*messages.add(
                          {
                            kMessage: data,
                            kCreatedAt: DateTime.now(),
                            'id': email
                          },
                        );*/
                controller.clear();
                _controller.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: /*GestureDetector(
                        onTap: () {
                          messages.add({
                            kMessage: controller,
                            kCreatedAt: DateTime.now(),
                            'id': email,
                          });
                          controller.clear();
                          _controller.animateTo(
                            0,
                            // _controller.position.maxScrollExtent,
                            curve: Curves.fastOutSlowIn,
                            duration: Duration(milliseconds: 500),
                          );
                        },
                        child:*/
                    InkWell(
                  onTap: () {
                    BlocProvider.of<ChatCubit>(context)
                        .sendMessage(message: controller.text, email: email);
                    //dataON = data;
                    /* messages.add(
                  {kMessage: data, kCreatedAt: DateTime.now(), 'id': email},
                );*/
                    controller.clear();
                    _controller.animateTo(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  child: const Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  ),
                ),
                //),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } /*else {
            return Scaffold(body: Center(child: Text('Loading...')));
          }*/
}
        //}
       // );
 // }
//}
