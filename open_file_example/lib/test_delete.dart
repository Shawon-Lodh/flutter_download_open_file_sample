import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class TestDelete extends StatefulWidget {
  const TestDelete({Key? key}) : super(key: key);

  @override
  _TestDeleteState createState() => _TestDeleteState();
}

class _TestDeleteState extends State<TestDelete> {

  bool downloadStarted = false;
  bool downloadCompleted = false;

  List<Widget> buttonActionsBeforeDownload = [
    IconsOutlineButton(
      onPressed: () {},
      text: 'MayBe Later',
      iconData: Icons.cancel_outlined,
      textStyle: const TextStyle(color: Colors.grey),
      iconColor: Colors.grey,
    ),
    IconsButton(
      onPressed: () {},
      text: 'Download',
      iconData: Icons.download,
      color: Colors.greenAccent,
      textStyle: const TextStyle(color: Colors.black),
      iconColor: Colors.black,
    ),
  ];
  List<Widget> buttonActionsAfterDownload = [
    IconsButton(
      onPressed: () {},
      text: 'Show File',
      iconData: Icons.download,
      color: Colors.greenAccent,
      textStyle: const TextStyle(color: Colors.black),
      iconColor: Colors.black,
    ),
  ];



  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {


      await Dialogs.materialDialog(
          msg: downloadStarted
              ? "Downloading file started"
              : 'You can now update this app from 0.1.1 \nto 0.1.3',
          title: "Update Available",
          color: Colors.white,
          context: context,
          actions: [
            IconsOutlineButton(
              onPressed: () {
                setState(() {
                  downloadStarted = true;
                });
                print(downloadStarted);
              },
              text: 'MayBe Later',
              iconData: Icons.cancel_outlined,
              textStyle: const TextStyle(color: Colors.grey),
              iconColor: Colors.grey,
            ),
            IconsButton(
              onPressed: () {},
              text: 'Download',
              iconData: Icons.download,
              color: Colors.greenAccent,
              textStyle: const TextStyle(color: Colors.black),
              iconColor: Colors.black,
            ),
          ]);


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog();
          },
          child: const Text("Show"),
        ),
      ),
    );
  }


  showDialog() {
    return Dialogs.materialDialog(
        msg: downloadStarted
            ? "Downloading file started"
            : 'You can now update this app from 0.1.1 \nto 0.1.3',
        title: "Update Available",
        color: Colors.white,
        context: context,
        actions: [
          IconsOutlineButton(
            onPressed: () {
              setState(() {
                downloadStarted = true;
              });
              print(downloadStarted);
            },
            text: 'MayBe Later',
            iconData: Icons.cancel_outlined,
            textStyle: const TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          ),
          IconsButton(
            onPressed: () {},
            text: 'Download',
            iconData: Icons.download,
            color: Colors.greenAccent,
            textStyle: const TextStyle(color: Colors.black),
            iconColor: Colors.black,
          ),
        ]);
  }
}

