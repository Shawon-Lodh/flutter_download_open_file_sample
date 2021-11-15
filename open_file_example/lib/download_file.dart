import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

const bookUrl = "https://dl.bdebooks.com/index.php/s/d82Xno3D6w7ySz7/download";
var dio = Dio();

class DownloadFileSample extends StatefulWidget {
  const DownloadFileSample({Key? key}) : super(key: key);


  @override
  _DownloadFileSampleState createState() => _DownloadFileSampleState();
}

class _DownloadFileSampleState extends State<DownloadFileSample> {

  Future download2(Dio dio, String url, String savePath) async {
    try {
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
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
                onPressed: () async {
                  var tempDir = await getTemporaryDirectory();
                  String fullPath = tempDir.path + "/boo2.pdf'";
                  print('full path ${fullPath}');

                  download2(dio, bookUrl, fullPath);
                },
                icon: const Icon(
                  Icons.file_download,
                  color: Colors.white,
                ),
                label: const Text('Download')),
          ],
        ),
      ),
    );
  }
}