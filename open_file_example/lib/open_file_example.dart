import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';

import 'package:open_file/open_file.dart';


class OpenFileExample extends StatefulWidget {
  @override
  _OpenFileExampleState createState() => _OpenFileExampleState();
}

class _OpenFileExampleState extends State<OpenFileExample> {
  var _openResult = 'Unknown';

  Future<void> openFile() async {
    var filePath = r'/storage/emulated/0/update.apk';
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      filePath = result.files.single.path!;
    } else {
      // User canceled the picker
    }
    final _result = await OpenFile.open(filePath);
    print(_result.message);

    setState(() {
      _openResult = "type=${_result.type}  message=${_result.message}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('open result: $_openResult\n'),
              TextButton(
                child: const Text('Tap to open file'),
                onPressed: openFile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}