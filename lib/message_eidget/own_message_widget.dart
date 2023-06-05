import 'package:flutter/material.dart';

class OwnMessageWidget extends StatelessWidget {
  final String sender;
  final String msg;

  const OwnMessageWidget({required this.sender, required this.msg, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 60),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.teal,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.amberAccent),
                ),
                const SizedBox(height: 6),
                Text(
                  msg,
                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.greenAccent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
