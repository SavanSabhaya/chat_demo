import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:soket_io_demo/message_weidget/other_message_widget.dart';
import 'package:soket_io_demo/message_weidget/own_message_widget.dart';
import 'package:soket_io_demo/model.dart';

class GroupPage extends StatefulWidget {
  final String name;
  final String userId;

  const GroupPage({Key? key, required this.name, required this.userId}) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  TextEditingController _meassagecontroller = TextEditingController();
  List<MsgModel> msgList = [];
  Map<String, dynamic>? data;
  IO.Socket? socket;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  void connect() {
    socket = IO.io('http://192.168.5.213:8081', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnet": false
    });
    socket!.connect();
    socket!.onConnect((_) => {
          print('connect'),
          socket!.emit('connect_chat_user', {"chat_id": 1, "type_id": 1, "type": 'customer'})
        });

    socket?.on("receive_message", (data) {
      print('data==>$data');
      if (data["chat_id"] != null) {
        setState(() {
          msgList.add(MsgModel(type: data["your_type"], msg: data["message"], sender: data["your_type"]));
        });
      }
    });
  }

  void sendMsg(String msg, String sendername) {
    MsgModel ownmsg = MsgModel(type: "ownmsg", msg: msg, sender: sendername);
    // msgList.add(ownmsg);
    setState(() {
      msgList;
    });
    socket!.emit("send_message", {"chat_id": 1, "send_by_id": 1, "send_by_type": 'customer', "message": msg, "message_type": 'text'});
    // socket!.emit('counter', {"type": "ownMsg", "msg": msg, "sendername": sendername, "userId": widget.userId});
  }

  void emit() {}

/*   void getData(Map<String, dynamic> dataa) {
    setState(() {
      data = dataa;
    });
    print('data==>${data?['title']}');
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('anomynous group'),
        actions: [
          IconButton(
              onPressed: () {
                emit();
              },
              icon: Icon(Icons.abc))
        ],
      ),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
          itemCount: msgList.length,
          itemBuilder: (context, index) {
            if (msgList[index].type == "sender") {
              return OwnMessageWidget(
                msg: msgList[index].msg,
                sender: msgList[index].sender,
              );
            } else {
              return OtherMeassgeWidget(
                msg: msgList[index].msg,
                sender: msgList[index].sender,
              );
            }
          },
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: _meassagecontroller,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          String msg = _meassagecontroller.text;
                          if (msg.isNotEmpty) {
                            sendMsg(_meassagecontroller.text, widget.name);
                            _meassagecontroller.clear();
                          }
                        },
                        icon: const Icon(Icons.send)),
                    hintText: 'Type here...',
                    border: OutlineInputBorder(borderSide: BorderSide(width: 2))),
              )),
            ],
          ),
        )
      ]),
    );
  }
}
