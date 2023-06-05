import 'package:flutter/material.dart';
import 'package:soket_io_demo/grouppage.dart';
import 'package:uuid/uuid.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var uuid = Uuid();

  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group chat app'),
      ),
      body: Center(
          child: TextButton(
        onPressed: () {
          nameController.clear();
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('please enter name'),
                    content: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.length < 3) {
                              return 'Enter valid name';
                            }
                            return null;
                          },
                        )),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancel')),
                      TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GroupPage(name: nameController.text, userId: '100')));
                            }
                          },
                          child: const Text('enter'))
                    ],
                  ));
        },
        child: const Text('Intial grop chat'),
      )),
    );
  }
}
