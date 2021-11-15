import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file_example/all_material_dialog.dart';
import 'package:open_file_example/local_notification_example.dart';
import 'package:open_file_example/test_delete.dart';
import 'package:open_file_example/meterial_dialog_with_download_progress.dart';


void main() async {
  /// needed for local Notification
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MaterialDialogsWithDownloadProgressBar(),
    );
  }
}