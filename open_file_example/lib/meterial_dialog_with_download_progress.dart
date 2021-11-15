import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

const bookUrl = "https://dl.bdebooks.com/index.php/s/d82Xno3D6w7ySz7/download";
var dio = Dio();

class MaterialDialogsWithDownloadProgressBar extends StatefulWidget {
  const MaterialDialogsWithDownloadProgressBar({Key? key}) : super(key: key);

  @override
  _MaterialDialogsWithDownloadProgressBarState createState() => _MaterialDialogsWithDownloadProgressBarState();
}

class _MaterialDialogsWithDownloadProgressBarState extends State<MaterialDialogsWithDownloadProgressBar> {

  bool downloadStarted = false;
  bool downloadCompleted = false;

  String fullPath = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _confirmDialog();
    });
  }

  // static Future<String> getExternalStoragePublicDirectory(String type) async {
  //   MethodChannel _channel = const MethodChannel('ext_storage');
  //   if (!Platform.isAndroid) {
  //     throw UnsupportedError("Only android supported");
  //   }
  //   return await _channel
  //       .invokeMethod('getExternalStoragePublicDirectory', {"type": type});
  // }

  Future download2(Dio dio, String url, String savePath) async {
    try {
      downloadStarted = true;
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      // print(response.headers);

      // storage permission ask
      // var status = await Permission.storage.status;
      // if (!status.isGranted) {
      //
      // }

      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();

    } catch (e) {
      downloadStarted = false;
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  Future<void> openFile() async   {
    print("Saved Path : ${fullPath}");
    var filePath = r'/storage/emulated/0/update.apk';
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
    );

    if (result != null) {
      filePath = result.files.single.path!;
    } else {
      // User canceled the picker
    }
    final _result = await OpenFile.open(filePath);
    print(_result.message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

   _confirmDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
              child: Container(
                height: 150,
                width: 250,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Update Available', style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                    Text(downloadStarted? (downloadCompleted ? "Successfully Downloaded" : "Downloading ...") : 'You can now update this app from 0.1.1 to 0.1.3', style: const TextStyle(color: Colors.black,fontSize: 12),),
                    downloadCompleted ? TextButton(onPressed: openFile, child: Text('Show File', style: TextStyle(color: Colors.purple, fontSize: 18.0),)) : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(onPressed: () {}, child: Text('Maybe Later', style: TextStyle(color: Colors.purple, fontSize: 18.0),)),
                        TextButton(
                            onPressed: () async {
                              print("Starting test , Download completed value : ${downloadCompleted}");
                              var tempDir = await getApplicationDocumentsDirectory();
                              // var tempDir = await getExternalStoragePublicDirectory("Download");
                              fullPath = tempDir.path + "/boo2.pdf'";
                              print('full path ${fullPath}');
                              setState((){
                                download2(dio, bookUrl, fullPath).then((value){
                                  setState((){
                                    downloadCompleted = true;
                                  });
                                  // print("Download completed value : ${downloadCompleted}");
                                });
                              });
                            },
                            child: Text('Download', style: TextStyle(color: Colors.purple, fontSize: 18.0),)),
                      ],
                    ),
                  ],
                ),
              ),
            );;
          });
        });
  }
}