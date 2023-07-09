import 'package:flutter/material.dart';
import 'package:chaquopy/chaquopy.dart';
import 'package:flutter_pickers/pickers.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Super Resolution',
      home: Home(),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  Future<void> sr() async {
    final _result = await Chaquopy.executeCode('');
    print(_result['textOutputOrError']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('Super Resolution'),
      ),
      // body is the majority of the screen.
      body: const MyBody(),
      floatingActionButton: const FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyBody extends StatefulWidget {
  const MyBody({super.key});

  @override
  State<MyBody> createState() {
    return _MybodyState();
  }
}

class _MybodyState extends State<MyBody> {
  var data = 'baby';
  var showPath = '';

  void change(String p) {
    setState(() {
      data = p;
    });
  }

  void press() async {
    final _result = await Chaquopy.executeCode(data);
    print(_result['textOutputOrError']);

    setState(() {
      // data2 = data;
      showPath = '/data/user/0/com.example.super_resolution/app_flutter/$data.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.red,
              child: InkWell(
                  onTap: () {
                    Pickers.showSinglePicker(
                      context,
                      data: ['baby', 'bird', 'butterfly', 'head', 'woman'],
                      selectData: data,
                      onConfirm: (p, position) {
                        setState(() {
                          data = p;
                        });
                      },
                    );
                  },
                  child: const Text('Select Image')),
            ),
            Container(
              width: 250,
              height: 250,
              child: Image(image: AssetImage('LR_x4/$data.png'), fit: BoxFit.cover),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: ElevatedButton(
              child: Text('test'),
              onPressed: press,
            )),
            Container(
              width: 250,
              height: 250,
              child: Image(
                  image: FileImage(File(showPath)), fit: BoxFit.cover),
            )
          ],
        ),
      ],
    );
  }
}
